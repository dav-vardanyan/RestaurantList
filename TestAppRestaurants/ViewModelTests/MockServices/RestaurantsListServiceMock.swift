//
//  RestaurantsListServiceMock.swift
//  ViewModelTests
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import DataManager

public final class RestaurantsListServiceMock: IRestaurantsListService {
    let parser: IParser = CodableParser()

    public init() {}
    public func getData<T: Decodable>(parameters: Params, onCompletion: @escaping (([T]) -> Void)) {
        if let path = Bundle.main.path(forResource: "SampleiOS", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let parsedData: ResponseDataContainer<T> = try parser.parsData(data: data)
                onCompletion(parsedData.restaurants)
            } catch {
                // in real case scenario we should handle error,
                // and send back to viewModel user friendly error message
                onCompletion([])
            }
        }
    }
}
