//
//  FavoriteServiceMock.swift
//  ViewModelTests
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import DataManager

final public class FavoriteServiceMock: IFavoriteService {
    public init() {}

    public func getFavoriteRestaurants() -> [String] {
        return []
    }

    public func isRestaurantFavorite(restaurantName: String) -> Bool {
        false
    }

    public func makeRestaurantFavorite(restaurantName: String, isFavorite: Bool) {
    }
}
