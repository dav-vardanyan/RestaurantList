//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import XCTest
@testable import ViewModel
import DataManager
import Combine

class ViewModelTests: XCTestCase {
    var sut: RestaurantsViewModel!
    private var cancellable = Set<AnyCancellable>()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupMockServices()
        sut = RestaurantsViewModel()
        cancellable.removeAll()
        sut.getItems()
    }

    private func setupMockServices() {
        RestaurantServices.deleteAll()
        RestaurantServices.register(service: FavoriteServiceMock())
        RestaurantServices.register(service: RestaurantsListServiceMock())
    }

    func testGetItems() {
        let expectation = XCTestExpectation(description: "Data not loaded")
        sut.$reloadData
        .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newValue in
            if newValue {
                XCTAssertEqual(self?.sut.items.count, 19)
                expectation.fulfill()
            }
            }).store(in: &cancellable)

        wait(for: [expectation], timeout: 1.0)
    }

    func testOrderSortSelected() {
        sut.orderSortSelected(key: .deliveryCosts)

        // highest delivery cost should be the first
        XCTAssertEqual(sut.items[0].sortingValue, "Delivery Costs:  500")

        sut.orderSortSelected(key: .newest)
        XCTAssertEqual(sut.items[0].sortingValue, "Newest:  272.0")
    }


    func testFilterRestaurants() {

        sut.filterRestaurants(restaurantName: "Sushi")


        let expectation = XCTestExpectation(description: "Sushi restaurants count is incorrect")
        sut.$reloadData
        .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] newValue in
            if newValue {
                XCTAssertEqual(self?.sut.items.count, 4)
                expectation.fulfill()
            }
            }).store(in: &cancellable)

        wait(for: [expectation], timeout: 1.0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
