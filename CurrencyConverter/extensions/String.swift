//
//  String.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 16.02.24.
//

import Foundation


extension String {
    func limitDigitsAfterDecimalPoint(maxDigits: Int) -> String {
        if let dotIndex = self.firstIndex(of: ".") {
            let decimalPart = self[self.index(after: dotIndex)...]
            if decimalPart.count > maxDigits {
                let endIndex = self.index(dotIndex, offsetBy: maxDigits + 1)
                return String(self[..<endIndex])
            }
        }
        return self
    }
}
