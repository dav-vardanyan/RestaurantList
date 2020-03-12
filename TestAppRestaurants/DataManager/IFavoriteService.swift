//
//  IFavoriteService.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation


public protocol IFavoriteService {
    func getFavoriteRestaurants() -> [String]
    func isRestaurantFavorite(restaurantName: String) -> Bool
    func makeRestaurantFavorite(restaurantName: String, isFavorite: Bool)
}

final public class FavoriteService: IFavoriteService {
    public init() {}

    public func getFavoriteRestaurants() -> [String] {
        return UserPreferences.favoriteList
    }

    public func isRestaurantFavorite(restaurantName: String) -> Bool {
        UserPreferences.favoriteList.contains(restaurantName)
    }

    public func makeRestaurantFavorite(restaurantName: String, isFavorite: Bool) {
        if isFavorite { // add to the list
            UserPreferences.favoriteList.append(restaurantName)
        } else {
            UserPreferences.favoriteList = UserPreferences.favoriteList.filter({ $0 != restaurantName })
        }
    }
}
