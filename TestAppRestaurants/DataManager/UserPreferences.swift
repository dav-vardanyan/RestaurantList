//
//  UserPreferences.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation

enum UserPreferencesKeys: String, CaseIterable {
    case favoriteListKey
}

public struct UserPreferences {
    @UserDefault(key: UserPreferencesKeys.favoriteListKey.rawValue, defaultValue: [])
    public static var favoriteList: [String]
}
