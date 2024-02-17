//
//  CurrencyCleanModel.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 16.02.24.
//

import Foundation

struct CurrencyConversionClean: Codable, Equatable {
    var from: Currency?
    var to: Currency?
    var amount: String?
    var rate: Double?
    var convertedAmount: String?

    static func == (lhs: CurrencyConversionClean, rhs: CurrencyConversionClean) -> Bool {
        return lhs.from == rhs.from &&
               lhs.to == rhs.to &&
               lhs.amount == rhs.amount &&
               lhs.rate == rhs.rate &&
               lhs.convertedAmount == rhs.convertedAmount
    }
}

extension CurrencyConversionClean {
    func toCurrencyConversion() -> CurrencyConversion {
        return CurrencyConversion(
            from: from ?? .eur,
            to: to ?? .usd,
            amount: amount ?? "",
            rate: rate ?? 0,
            convertedAmount: convertedAmount ?? ""
        )
    }
}

