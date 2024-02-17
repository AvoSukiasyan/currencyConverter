//
//  CurrencyConverterResponse.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

class CurrencyResponse: Codable {
    var date: String?
    var historical: String?
    var info: CurrencyConverterInfo?
    var query: CurrencyConverterQuery
    var result: Double?
    var success: Bool
}

class CurrencyConverterInfo: Codable {
    var rate: Double?
    var timestamp: Int64?
}

class CurrencyConverterQuery: Codable {
    var amount: Double?
    var from: String?
    var to: String?
}
