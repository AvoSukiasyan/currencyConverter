//
//  APIService.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 15.02.24.
//

import Foundation

protocol APIServiceProvider {
    var networkService: NetworkService { get }
    func getData(data: CurrencyConversionClean, completion: @escaping (Result<Data, Error>) -> Void)
}

class APIService: APIServiceProvider {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getData(data: CurrencyConversionClean, completion: @escaping (Result<Data, Error>) -> Void) {
        networkService.makeRequest(data: data.toCurrencyConversion()) { result in
            switch result {
            case .failure(let error):
                if let error = error {
                       completion(.failure(error))
                   }
            case .success(let responseData):
                completion(.success(responseData))
            }
        }
    }
}

