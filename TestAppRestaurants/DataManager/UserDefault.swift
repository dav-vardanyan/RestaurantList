//
//  UserDefault.swift
//  TestAppRestaurants
//
//  Created by David V on 3/12/20.
//  Copyright © 2020 davidv. All rights reserved.
//

import Foundation


@propertyWrapper
public struct UserDefault<T> {
    internal init(key: String,
                  defaultValue: T,
                  store: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    let key: String
    let defaultValue: T
    let store: UserDefaults
    public var wrappedValue: T {
        get {
            return store.object(forKey: key) as? T ?? defaultValue
        }
        set {
            store.set(newValue, forKey: key)
        }
    }
}
