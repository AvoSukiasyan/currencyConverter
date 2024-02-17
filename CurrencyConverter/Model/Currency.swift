//
//  CurrencyObject.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

enum Currency: String, Identifiable, Codable {
    var id: String {
        return self.rawValue
    }
    
    case rub = "RUB"
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case chf = "CHF"
    case cny = "CNY"
    
    static let allValues = [rub, usd, eur, gbp, chf, cny]
    
    
    var title: String {
        switch self {
        case .rub:
            return "Rubles"
        case .usd:
            return "US Dollars"
        case .eur:
            return "Euro"
        case .gbp:
            return "British Pound"
        case .chf:
            return "Swiss Franc"
        case .cny:
            return "Chinese Yuan"
        }
    }
    
    
    var flag: String {
        switch self {
        case .rub:
            return "RUB"
        case .usd:
            return "USD"
        case .eur:
            return "EUR"
        case .gbp:
            return "GBP"
        case .chf:
            return "CHF"
        case .cny:
            return "CNY"
        }
    }
}
