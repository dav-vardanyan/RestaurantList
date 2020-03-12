//
//  AppViewModel.swift
//  ViewModel
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation
import DataManager

public class AppViewModel {

    public init() {
        RestaurantServices.setup()
    }
}
