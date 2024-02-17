//
//  CurrencyPairRepo.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import Foundation

protocol CurrencyPairRepositoryProvider {
    func requestCurrencyPair(data: CurrencyConversionClean, completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void)
    func getLastCurrencyObject() -> CurrencyConversionClean?
    func getHistory() -> [CurrencyConversionClean]
}

class CurrencyPairRepository: CurrencyPairRepositoryProvider {
    
    private var localPairs: [LocalPair] = []
    private let localService: LocalServiceProvider
    private let apiService: APIServiceProvider
    private var currencyConvertingHistory: [CurrencyConversion] = []
    
    init(localService: LocalServiceProvider,
         apiService: APIServiceProvider) {
        self.localService = localService
        self.apiService = apiService
    }
    
    func getLastCurrencyObject() -> CurrencyConversionClean? {
        return localService.getLastCurrencyObject()
    }
    
    func getHistory() -> [CurrencyConversionClean] {
        return localService.getPairHistory()
    }
    
    func requestCurrencyPair(data: CurrencyConversionClean, completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void)  {
        let key = (data.from?.rawValue ?? "") + (data.to?.rawValue ?? "")
        if let pair = localPairs.first(where: { $0.currencies == key }),
           let amount = Double(data.amount ?? "") {
            let response = CurrencyResponseClean(
                rate: pair.rate,
                convertedAmount: pair.rate * amount
            )
            completion(.success(response))
        } else if ReachabilityManager.shared.isReachable() {
            fetchCurrencyPairFromAPI(data: data, completion: completion)
        } else {
            localService.getLocalCurrencyPair(data: data, completion: completion)
        }
    }
    
    private func fetchCurrencyPairFromAPI(data: CurrencyConversionClean, completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void) {
        apiService.getData(data: data) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.localService.getLocalCurrencyPair(data: data, completion: completion)
            case .success(let dt):
                self?.handleSuccessResponse(currency: data, data: dt,completion: completion)
            }
        }
    }
    
    private func handleSuccessResponse(currency: CurrencyConversionClean, data: Data, completion: @escaping (Result<CurrencyResponseClean, Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(CurrencyResponse.self, from: data)
            guard let rate = response.info?.rate,
                  let amount = response.query.amount,
                  let from = response.query.from,
                  let to = response.query.to else {
                return
            }
            let cleanResponse = CurrencyResponseClean(rate: rate, convertedAmount: rate * amount)
            self.localPairs.append(LocalPair(currencies: from + to, rate: rate))
            completion(.success(cleanResponse))
            self.localService.storeRates(rate: rate, key: from+to)
            self.localService.storeCurrencyLastPair(data: CurrencyConversionClean(from: currency.from,
                                                                                  to: currency.to,
                                                                                  amount: currency.amount,
                                                                                  rate: rate,
                                                                                  convertedAmount: cleanResponse.convertedAmount?.description.limitDigitsAfterDecimalPoint(maxDigits: 4)))
        } catch (let error) {
            completion(.failure(error))
            print("Error decoding response: \(error)")
        }
    }
}
