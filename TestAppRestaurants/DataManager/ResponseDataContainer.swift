//
//  ResponseDataContainer.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation


public struct ResponseDataContainer<Data: Decodable>: Decodable {
    public let restaurants: [Data]

    enum CodingKeys: String, CodingKey {
        case restaurants = "restaurants"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurants = try values.decode([Data].self, forKey: .restaurants)
    }
}
