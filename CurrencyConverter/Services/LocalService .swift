//
//  LocalService .swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import Foundation


protocol LocalServiceProvider {
    func storeRates(rate: Double, key: String)
    func storeCurrencyLastPair(data: CurrencyConversionClean)
    
    func getRate(key: String) -> Double?
    func getLastCurrencyObject() -> CurrencyConversionClean?
    func getLocalCurrencyPair(data: CurrencyConversionClean,
                              completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void)
    func getPairHistory() -> [CurrencyConversionClean]
}

class LocalService: LocalServiceProvider {
    
    var history: [CurrencyConversionClean] = []
    var userDefaultsManager: UserDefaultsManager
    
    init(userDefaultsManager: UserDefaultsManager) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getPairHistory() -> [CurrencyConversionClean] {
        let pairs: [CurrencyConversionClean] = userDefaultsManager.getArray(forKey: UserDefaults.Key.CurrencyConvertor.history.rawValue) ?? []
        return pairs
    }
    
    func storeRates(rate: Double, key: String) {
        userDefaultsManager.setValue(rate, forKey: key)
    }
    
    func storeCurrencyLastPair(data: CurrencyConversionClean) {
        let key = UserDefaults.Key.CurrencyConvertor.lastUsedPair.rawValue
        userDefaultsManager.setObject(data, forKey: key)
        updateHistory(with: data)
    }
    
    func getRate(key: String) -> Double? {
        return userDefaultsManager.value(forKey: key) as? Double
    }
    
    func getLastCurrencyObject() -> CurrencyConversionClean? {
        let pair: CurrencyConversionClean? = userDefaultsManager.getObject(forKey: UserDefaults.Key.CurrencyConvertor.lastUsedPair.rawValue)
        return CurrencyConversionClean(from: pair?.from, to: pair?.to)
    }
    
    func getLocalCurrencyPair(data: CurrencyConversionClean, completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void) {
        let key = (data.from?.rawValue ?? "") + (data.to?.rawValue ?? "")
        if let rate = getRate(key: key), let amount = Double(data.amount ?? "") {
            let response = CurrencyResponseClean(rate: rate, convertedAmount: rate * amount)
            completion(.success(response))
        } else {
            //completion(.failure(Error("No Internet Connection")))
        }
    }
    
    private func updateHistory(with pair: CurrencyConversionClean) {
        let key = UserDefaults.Key.CurrencyConvertor.history.rawValue
        var pairs = getPairHistory()
        if pairs.first == pair {
            return 
        }
        pairs.insert(pair, at: 0)
        userDefaultsManager.setArray(pairs, forKey: key)
    }
}
