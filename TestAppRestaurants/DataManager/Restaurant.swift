//
//  Restaurant.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation

public struct Restaurant: Codable {
    public let name: String
    public let status: Status
    public let sortingValues: SortingValues
}

public enum Status: String, Codable {
    case open
    case closed
    case orderAhead = "order ahead"
}

public struct SortingValues: Codable {
    public let bestMatch: Double
    public let newest: Double
    public let ratingAverage: Double
    public let distance: Int
    public let popularity: Double
    public let averageProductPrice: Int
    public let deliveryCosts: Int
    public let minCost: Int
}
