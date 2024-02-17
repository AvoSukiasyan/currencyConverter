//
//  CurrencyConverterViewModelTests.swift
//  CurrencyConverterTests
//
//  Created by Avetik Sukiasyan on 17.02.24.
//

import XCTest
@testable import CurrencyConverter // Import the module where CurrencyConverterViewModel is defined

class CurrencyConverterViewModelTests: XCTestCase {
    
    var viewModel: CurrencyConverterViewModel!
    var mockRepository: MockCurrencyPairRepositoryProvider!

    override func setUp() {
        super.setUp()
        mockRepository = MockCurrencyPairRepositoryProvider()
        viewModel = CurrencyConverterViewModel(repository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testMakeRequestSuccess() {
        // Test handling successful response from repository
        let expectation = XCTestExpectation(description: "Response received")
        
        // Simulate successful response from repository
        mockRepository.shouldSucceed = true
        
        viewModel.makeRequest()
        
        // Wait for response handling
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.loading)
            // Add assertions to verify other properties or states after successful response handling
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    func testMakeRequestFailure() {
        // Test handling failure response from repository
        let expectation = XCTestExpectation(description: "Response received")
        
        // Simulate failure response from repository
        mockRepository.shouldSucceed = false
        
        viewModel.makeRequest()
        
        // Wait for response handling
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.loading)
            // Add assertions to verify other properties or states after failure response handling
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    // Write more tests to cover other functionalities of your view model
    
}

// Mock implementation of CurrencyPairRepositoryProvider for testing
class MockCurrencyPairRepositoryProvider: CurrencyPairRepositoryProvider {
    func requestCurrencyPair(data: CurrencyConverter.CurrencyConversionClean, completion: @escaping (Result<CurrencyConverter.CurrencyResponseClean, Error>) -> Void) {
        
    }
    
    func getLastCurrencyObject() -> CurrencyConverter.CurrencyConversionClean? {
        return CurrencyConversionClean()
    }
    
    
    var shouldSucceed: Bool = true // Indicates whether requests should succeed or fail
    let history: [CurrencyConversion] = [] // Provide initial history for testing
    
    func getLastCurrencyObject() -> CurrencyConversion? {
        return CurrencyConversion(from: .usd, to: .eur)
        // Mock implementation to return a currency conversion object
    }
    
    func getHistory() -> [CurrencyConversionClean] {
        // Mock implementation to return history
        return []
    }
    
    func requestCurrencyPair(data: CurrencyConversionClean, completion: @escaping (Result<CurrencyResponseClean?, Error>) -> Void) {
        // Simulate asynchronous request handling
        DispatchQueue.global().async {
            if self.shouldSucceed {
                // Simulate successful response
                let response = CurrencyResponseClean(rate: 1.2, convertedAmount: 100.0)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } else {
                // Simulate failure response
                let error = NSError(domain: "TestDomain", code: 500, userInfo: nil)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}
