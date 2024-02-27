//
//  SharedAppStorage.swift
//  Lifeline
//
//  Created by Vlad Z on 25/02/2024.
//

import Foundation

import SwiftUI

@propertyWrapper
struct SharedAppStorage<T> {
    private let key: String
    private let defaultValue: T
    private let sharedUserDefaults: UserDefaults?

    var wrappedValue: T {
        get {
            return sharedUserDefaults?.object(forKey: key) as? T ?? defaultValue
        }
        nonmutating set {
            sharedUserDefaults?.set(newValue, forKey: key)
        }
    }

    init(wrappedValue defaultValue: T, _ key: String) {
        self.key = key
        self.defaultValue = defaultValue
        self.sharedUserDefaults = UserDefaults(suiteName: "group.com.vladz.lifeline")
    }
}
