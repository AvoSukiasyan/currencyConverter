//
//  CarrencyObject.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import SwiftUI


class CurrencyConversion: ObservableObject, Identifiable, Equatable {
    
    @Published var from: Currency
    @Published var to: Currency
    @Published var amount: String
    @Published var rate: Double?
    @Published var convertedAmount: String

    init(from: Currency, to: Currency, amount: String = "", rate: Double? = nil, convertedAmount: String = "") {
        self.from = from
        self.to = to
        self.amount = amount
        self.rate = rate
        self.convertedAmount = convertedAmount
    }
    
    static func == (lhs: CurrencyConversion, rhs: CurrencyConversion) -> Bool {
        return lhs.from == rhs.from &&
               lhs.to == rhs.to &&
               lhs.amount == rhs.amount &&
               lhs.rate == rhs.rate &&
               lhs.convertedAmount == rhs.convertedAmount
    }
}

extension CurrencyConversion {
    func toCurrencyConversionClean() -> CurrencyConversionClean {
        return CurrencyConversionClean(
            from: from,
            to: to,
            amount: amount,
            rate: rate,
            convertedAmount: convertedAmount
        )
    }
}

