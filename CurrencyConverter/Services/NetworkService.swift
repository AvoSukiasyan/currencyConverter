//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Avetik Sukiasyan on 14.02.24.
//

import Foundation

protocol NetworkServiceProvider {
    func makeRequest(data: CurrencyConversion, completion: @escaping CompletionValueWithError<Data>)
}

class NetworkService: NetworkServiceProvider {
    
    private let apiKey = "T19QLVjYpc3UhhpSMXQGqnVUv9aXVdxu"
    private let path = "/exchangerates_data/convert"
    private let baseURL = "https://api.apilayer.com"
    
    func makeRequest(data: CurrencyConversion, completion: @escaping CompletionValueWithError<Data>) {
        var urlComponents = URLComponents(string: baseURL + path)!
        urlComponents.queryItems = [
            URLQueryItem(name: "from", value: data.from.rawValue),
            URLQueryItem(name: "to", value: data.to.rawValue),
            URLQueryItem(name: "amount", value: data.amount)
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.allHTTPHeaderFields = ["apikey": apiKey]
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        dataTask.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping CompletionValueWithError<Data>) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        switch httpResponse.statusCode {
        case 200..<300:
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(ResponseError.invalidData))
            }
        default:
            if let data = data,
               let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
               let json = jsonObject as? [String: Any],
               let message = json["message"] as? String {
                completion(.failure(ResponseError.failed(message)))
            } else {
                completion(.failure(ResponseError.unknown))
            }
        }
    }
}
