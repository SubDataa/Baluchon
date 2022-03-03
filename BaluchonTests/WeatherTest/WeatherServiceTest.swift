//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 29/11/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(lat: "", lon: "") { (success, weather) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(lat: "", lon: "") { (success, weather) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(lat: "", lon: "") { (success, weather) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(lat: "", lon: "") { (success, weather) in
            //then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(lat: "", lon: "") { (success, weather) in
            //then
            let name = "New York"
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            XCTAssertEqual(name, weather?.cityName)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    
}
