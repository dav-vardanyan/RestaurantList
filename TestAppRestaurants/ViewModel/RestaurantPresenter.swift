//
//  RestaurantPresenter.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import DataManager


public struct RestaurantPresenter {
    public let name: String
    public let status: Status
    public let sortingValues: SortingValues

    public var isFavorite: Bool? = false
    public var currentSortingKey: SortingKey = .bestMatch
    public var sortingValue: String {
        var value = ""
        switch self.currentSortingKey {
        case .bestMatch:
            value = String(sortingValues.bestMatch)
        case .newest:
            value = String(sortingValues.newest)
        case .ratingAverage:
            value = String(sortingValues.ratingAverage)
        case .distance:
            value = String(sortingValues.distance)
        case .popularity:
            value = String(sortingValues.popularity)
        case .averageProductPrice:
            value = String(sortingValues.averageProductPrice)
        case .deliveryCosts:
            value = String(sortingValues.deliveryCosts)
        case .minCost:
            value = String(sortingValues.minCost)
        }
        return "\(currentSortingKey.description):  \(value)"
    }

    public init(restaurant: Restaurant) {
        self.name = restaurant.name
        self.status = restaurant.status
        self.sortingValues = restaurant.sortingValues
    }

}
