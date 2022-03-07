//
//  CurrencyServiceTest.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//


import XCTest
@testable import Baluchon

class CurrencyServiceTestCase: XCTestCase {
   
    var currencyService: CurrencyService!
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://google.com")!
    
    override func setUp() {
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = CurrencyFakeResponseData.currencyIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfError() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseOK!
            let error: Error? = CurrencyFakeResponseData.error
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getCurrency(from: "String", to: "String", amount: "") { (success, currency) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getCurrency(from: "String", to: "String", amount: "") { (success, currency) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = CurrencyFakeResponseData.currencyCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)
        
      
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getCurrency(from: "String", to: "String", amount: "") { (success, currency) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        // given

        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = CurrencyFakeResponseData.currencyIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getCurrency(from: "String", to: "String", amount: "") { (success, currency) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = CurrencyFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = CurrencyFakeResponseData.currencyCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        currencyService = CurrencyService(session: urlSession)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getCurrency(from: "String", to: "String", amount: "") { (success, currency) in
            //then
            let result = "9.00"
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)
            XCTAssertEqual(result, currency?.result)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    
}
