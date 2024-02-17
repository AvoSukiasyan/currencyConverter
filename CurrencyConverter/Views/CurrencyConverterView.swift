//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import SwiftUI

struct CurrencyConverterView: View {
    @ObservedObject var viewModel: CurrencyConverterViewModel
    @State private var selectionType: CurrencyType?
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 15) {
                    CurrencyCardView(title: "Amount", action: { selectionType = .base }, currency: $viewModel.currencyConversion.from, amount: $viewModel.currencyConversion.amount, type: .base)
                    
                    CurrencyCardView(title: "Converted Amount", action: { selectionType = .target }, currency: $viewModel.currencyConversion.to, amount: $viewModel.currencyConversion.convertedAmount, type: .target)
                    
                    exchangeRateView()
                    
                    Spacer()
                    
                    NavigationLink("Currency Converter History") {
                        CurrencyConverterHistory(history: $viewModel.history)
                    }
                }
                .padding(.horizontal, 20)
                .navigationTitle("Currency Converter")
                .navigationBarTitleDisplayMode(.large)
                .sheet(item: $selectionType) { item in
                    CurrencyListView(selectedItem: item == .base ? $viewModel.currencyConversion.from : $viewModel.currencyConversion.to)
                }
                if viewModel.loading {
                    ProgressView()
                }
            }
        }
    }
    
    @ViewBuilder
    private func exchangeRateView() -> some View {
        VStack {
            Text("Indicative Exchange Rate")
                .foregroundColor(Color.black.opacity(0.4))
            
            if let rate = viewModel.currencyConversion.rate,rate != 0, !viewModel.currencyConversion.amount.isEmpty {
                Text("1 \(viewModel.currencyConversion.from.title) = \(rate.description.limitDigitsAfterDecimalPoint(maxDigits: 4)) \(viewModel.currencyConversion.to.title)")
            }
        }
    }
}

#Preview {
    CurrencyConverterView(viewModel: CurrencyConverterViewModel(
        repository: CurrencyPairRepository(
            localService: LocalService(
            userDefaultsManager: UserDefaultsManager()), 
            apiService: APIService(networkService: NetworkService()))))
}

