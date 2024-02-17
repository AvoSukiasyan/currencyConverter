//
//  ResponseError.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation


public enum ResponseError: Error {
    
    case failed(String?)
    case unknown
    case invalidData
    
    public var localizedDescription: String {
        switch self {
        case .failed(let message):  return message ?? "Operation Failed"
        case .unknown:              return "Unknown Response Error"
        case .invalidData:          return "Invalid Response Data"
        }
    }
}
