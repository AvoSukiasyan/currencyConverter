//
//  CurrencyConverterViewNew.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation
import Combine

protocol CurrencyConverterViewModelProvider {
    var repository: CurrencyPairRepositoryProvider { get set }
    var currencyConversion: CurrencyConversion { get set }
    var history: [CurrencyConversion] { get }
    func makeRequest()
}

class CurrencyConverterViewModel: ObservableObject, CurrencyConverterViewModelProvider {
    
    var repository: CurrencyPairRepositoryProvider
    
    private var cancellable: AnyCancellable?
    
    @Published var loading: Bool = false
    @Published var history: [CurrencyConversion] = []
    @Published var isShowingAlert = false
    @Published var errorMssage: String = "Error"
    @Published var currencyConversion: CurrencyConversion {
        didSet {
            if currencyConversion.amount.isEmpty {
                DispatchQueue.main.async {
                    self.currencyConversion.convertedAmount = ""
                }
            }
            checkIfRequestIsReady()
        }
    }
    
    init(repository: CurrencyPairRepositoryProvider) {
        self.repository = repository
        currencyConversion = repository.getLastCurrencyObject()?.toCurrencyConversion() ?? CurrencyConversion(from: .usd, to: .eur)

        DispatchQueue.main.async { [weak self] in
            self?.history = repository.getHistory().map { $0.toCurrencyConversion() }
        }
    }

    private func checkIfRequestIsReady() {
        guard !currencyConversion.amount.isEmpty else {
            return
        }
        DispatchQueue.main.async {
            self.loading = true
            self.isShowingAlert = false
        }
        makeRequest()
    }
    
    private func handleData(response: CurrencyResponseClean?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loading = false
            self.currencyConversion.convertedAmount = (response?.convertedAmount?.description ?? "").limitDigitsAfterDecimalPoint(maxDigits: 3)
            self.currencyConversion.rate = response?.rate
            self.history = self.repository.getHistory().map { $0.toCurrencyConversion() }
        }
    }
    
    func makeRequest() {
        self.repository.requestCurrencyPair(data: currencyConversion.toCurrencyConversionClean()) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleData(response: data)
                DispatchQueue.main.async {
                    self?.loading = false
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self?.errorMssage = error.localizedDescription
                    self?.isShowingAlert = true
                    self?.loading = false
                }
            }
        }
    }
}
