//
//  TranslateServiceTest.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//
//


import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {
    var translateService: TranslateService!
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://google.com")!
    
    override func setUp() {
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = TranslateFakeResponseData.translateIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
    }
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseOK!
            let error: Error? = TranslateFakeResponseData.error
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate() { (success, translate) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
        
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate() { (success, translate) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = TranslateFakeResponseData.translateCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate() { (success, translate) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = TranslateFakeResponseData.translateIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate() { (success, translate) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = TranslateFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = TranslateFakeResponseData.translateCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        translateService = TranslateService(session: urlSession)
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslate() { (success, translate) in
            //then
            let text = "Good morning"
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            XCTAssertEqual(text, translate?.translatedText)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    
}
