//
//  CurrencyResponseClean.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 16.02.24.
//

import Foundation

class CurrencyResponseClean {
    
    let rate: Double?
    var convertedAmount: Double?
    
    init(rate: Double?, convertedAmount: Double?) {
        self.rate = rate
        self.convertedAmount = convertedAmount
    }
}
