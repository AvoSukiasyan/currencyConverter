//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import SwiftUI
import SwiftData

@main
struct CurrencyConverterApp: App {
    var body: some Scene {
        WindowGroup {
            CurrencyConverterView(viewModel: CurrencyConverterViewModel(
                repository: CurrencyPairRepository(localService: LocalService(userDefaultsManager: UserDefaultsManager()),
                                             apiService: APIService(networkService: NetworkService()))))
        }
    }
}
