//
//  ViewModel+Extension.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import DataManager

extension Status {
    var priority: Int {
        switch self {
        case .open:
            return 2
        case .orderAhead:
            return 1
            case .closed:
            return 0
        }
    }

    public var description: String {
        switch self {
        case .open:
            return "Open"
        case .closed:
            return "Closed"
        case .orderAhead:
            return "Order Ahead"
        }
    }
}
public enum SortingKey : String, CaseIterable {
    case bestMatch
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost

    public var description: String {
        switch self {
        case .bestMatch:
            return "Best Match"
        case .newest:
            return "Newest"
        case .ratingAverage:
            return "Rating"
        case .distance:
            return "Distance"
        case .popularity:
            return "Popular"
        case .averageProductPrice:
            return "Product Price"
        case .deliveryCosts:
            return "Delivery Costs"
        case .minCost:
            return "Min Cost"
        }
    }

}

extension SortingValues {
    subscript(key: String) -> Double? {
        switch key {
        case SortingKey.bestMatch.rawValue : return bestMatch
        case SortingKey.newest.rawValue : return newest
        case SortingKey.ratingAverage.rawValue : return ratingAverage
        case SortingKey.distance.rawValue : return Double(distance)
        case SortingKey.popularity.rawValue : return popularity
        case SortingKey.averageProductPrice.rawValue: return Double(averageProductPrice)
        case SortingKey.deliveryCosts.rawValue : return Double(deliveryCosts)
        case SortingKey.minCost.rawValue : return Double(minCost)
        default : return nil
        }
    }
}
