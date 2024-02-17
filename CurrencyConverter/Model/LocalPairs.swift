//
//  LocalData.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import Foundation


class LocalPair {
    let currencies: String
    let rate: Double
    
    init(currencies: String, rate: Double) {
        self.currencies = currencies
        self.rate = rate
    }
}
