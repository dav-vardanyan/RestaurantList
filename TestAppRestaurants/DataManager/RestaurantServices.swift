//
//  RestaurantServices.swift
//  DataManager
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation


public final class RestaurantServices {
private static var services: [Any] = []

    public static func setup() {
        registerFavoriteService()
        registerRestaurantsListService()
    }

    static private func registerFavoriteService() {
        let favoriteService = FavoriteService()
        RestaurantServices.register(service: favoriteService)
    }

    static private func registerRestaurantsListService() {
        let restaurantsListService = RestaurantsListService()
        RestaurantServices.register(service: restaurantsListService)
    }

    public static func get<T>() -> T {
        let service = services.first(where: { $0 is T })

        if let currentResult = service as? T {
            return currentResult
        } else {
            fatalError("Couldn't find registered service \(T.self)")
        }
    }

    static public func deleteAll() {
        services.removeAll()
    }

    static public func register<T: ExpressibleByNilLiteral>(service: T) {
       fatalError("Couldn't register service \(T.self)")
    }

    static public func register<T>(service: T) {
        return services.append(service)
    }
}
