//
//  CurrencyServiceTest.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//


import XCTest
@testable import Baluchon

class CurrencyServiceTestCase: XCTestCase {
    
    func testGetCurrencyShouldPostFailedCallbackIfError() {
        // given
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: CurrencyFakeResponseData.error))
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
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: nil))
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
        let currencyService = CurrencyService(session: URLSessionFake(data: CurrencyFakeResponseData.currencyCorrectData, response: CurrencyFakeResponseData.responseKO, error: nil))
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
        let currencyService = CurrencyService(session: URLSessionFake(data: CurrencyFakeResponseData.currencyIncorrectData, response: CurrencyFakeResponseData.responseOK, error: nil))
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
        let currencyService = CurrencyService(session: URLSessionFake(data: CurrencyFakeResponseData.currencyCorrectData, response: CurrencyFakeResponseData.responseOK, error: nil))
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
