//
//  UserDefaultsKeys.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

extension UserDefaults {
    struct Key: RawRepresentable {
        var rawValue: String
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

extension UserDefaults.Key {
    struct CurrencyConvertor {
        static let responsesForPairs = UserDefaults.Key(rawValue: "responsesForPairs")
        static let lastUsedPair = UserDefaults.Key(rawValue: "lastUsedPair")
        static let history =  UserDefaults.Key(rawValue: "history")
    }
}

