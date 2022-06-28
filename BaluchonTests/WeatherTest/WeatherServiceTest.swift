//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 29/11/2021.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {
    
    var weatherService: WeatherService!
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://google.com")!
    
    override func setUp() {
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = WeatherFakeResponseData.weatherIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        weatherService = WeatherService(session: urlSession)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // given
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseKO!
            let error: Error? = WeatherFakeResponseData.error
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(session: session)
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
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = nil
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(session: session)
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
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseKO!
            let error: Error? = nil
            let data: Data? = WeatherFakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(session: session)
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
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = WeatherFakeResponseData.weatherIncorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(session: session)
        
        
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
        MockURLProtocol.requestHandler = { request in
            let response: HTTPURLResponse = WeatherFakeResponseData.responseOK!
            let error: Error? = nil
            let data: Data? = WeatherFakeResponseData.weatherCorrectData
            return (response, data, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(session: session)
        
        
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
