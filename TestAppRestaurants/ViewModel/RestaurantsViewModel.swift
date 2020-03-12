//
//  RestaurantsViewModel.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import Combine
import DataManager

public typealias RestaurantSort = (RestaurantPresenter, RestaurantPresenter) -> Bool

public class RestaurantsViewModel {

    public var items: [RestaurantPresenter] = []
    @Published public var reloadData = false
    @Published public var sortingKey = SortingKey.bestMatch

    private var allItems: [RestaurantPresenter] = []
    private let restaurantList: IRestaurantsListService =  RestaurantServices.get()
    private let favoriteService: IFavoriteService =  RestaurantServices.get()


    public init() {}

    public func getRestaurantAt(index: Int) -> RestaurantPresenter? {
        guard !items.isEmpty, index < items.count else { return nil }
        return items[index]
    }

    public func getItems() {
        let params = Params()
        restaurantList.getData(parameters: params,
                            onCompletion: { [weak self](data) in
                                self?.handleResponse(restaurants: data)
        })
    }

    public func filterRestaurants(restaurantName: String) {
        guard !restaurantName.isEmpty else {
            items = allItems
            sortRestaurants()
            return
        }
        let filteredRestaurants = items.filter({ $0.name.contains(restaurantName)})
        items = filteredRestaurants
        reloadData = true
    }

    public func favoriteButtonPressed(index: Int) {
        guard !items.isEmpty, index < items.count else { return }
        items[index].isFavorite = !(items[index].isFavorite ?? false)
        favoriteService.makeRestaurantFavorite(restaurantName: items[index].name,
                                               isFavorite: items[index].isFavorite ?? false)
        sortRestaurants()
    }

    public func orderSortSelected(key: SortingKey) {
        self.sortingKey = key
        sortRestaurants()
    }

    public static func orderSort( sortingName: String) -> RestaurantSort {
        return { (rest1 : RestaurantPresenter, rest2: RestaurantPresenter) in
            guard let rest1Value = rest1.sortingValues[sortingName],
                  let rest2Value = rest2.sortingValues[sortingName] else { return false }
            return rest1Value > rest2Value
        }
    }


    private func sortRestaurants() {
        for (index, _) in items.enumerated() {
            items[index].currentSortingKey = sortingKey
        }
        var favoriteRestaurants = items.filter({ $0.isFavorite ?? false })
        var nonFavoriteRestaurants = items.filter({ !($0.isFavorite ?? false) })
        let sortingCriteria = { (rest1 : RestaurantPresenter, rest2: RestaurantPresenter) -> Bool in
            if rest1.status.priority == rest2.status.priority {
                let compareFunction =  RestaurantsViewModel.orderSort(sortingName: self.sortingKey.rawValue)
                return compareFunction(rest1, rest2)
            }
            return rest1.status.priority > rest2.status.priority
        }
        // sort favorite and nonFavorite restaurants by opening status
        favoriteRestaurants.sort(by: sortingCriteria)
        nonFavoriteRestaurants.sort(by: sortingCriteria)


        items = favoriteRestaurants + nonFavoriteRestaurants
        reloadData = true

    }

    private func handleResponse(restaurants: [Restaurant]) {
        var tempRestaurants  = restaurants.map({ RestaurantPresenter(restaurant: $0) })
        // handle favorite restaurants
        for (index, restaurant) in tempRestaurants.enumerated() {
            if favoriteService.isRestaurantFavorite(restaurantName: restaurant.name) {
                tempRestaurants[index].isFavorite = true
            }
        }

        self.items = tempRestaurants
        self.allItems = items
        // sort response before rendering on UI
        sortRestaurants()
        reloadData = true
    }
}
