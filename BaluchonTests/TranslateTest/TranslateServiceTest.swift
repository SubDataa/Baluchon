//
//  TranslateServiceTest.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//



import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // given
        let translateService = TranslateService(session: URLSessionFake(data: nil, response: nil, error: TranslateFakeResponseData.error))
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
        let translateService = TranslateService(session: URLSessionFake(data: nil, response: nil, error: nil))
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
        let translateService = TranslateService(session: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseKO, error: nil))
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
        let translateService = TranslateService(session: URLSessionFake(data: TranslateFakeResponseData.translateIncorrectData, response: TranslateFakeResponseData.responseOK, error: nil))
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
        let translateService = TranslateService(session: URLSessionFake(data: TranslateFakeResponseData.translateCorrectData, response: TranslateFakeResponseData.responseOK, error: nil))
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
