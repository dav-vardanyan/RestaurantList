//
//  IParser.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation


public protocol IParser {
    func parsData<T: Decodable>(data: Data) throws -> T
}


final public class CodableParser: IParser {
    public init() {}

    public func parsData<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }

}
