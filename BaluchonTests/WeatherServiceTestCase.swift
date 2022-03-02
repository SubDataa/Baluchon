//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 24/02/2022.
//


import XCTest
@testable import Baluchon


class WeatherServiceTestCase: XCTestCase {
    let fakeURL = URL(string: "test")
    func testGetWeatherIfError() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))
        //When
       
        weatherService.getWeather(url: fakeURL!) { (data) in
        //then
            XCTAssertNil(data)
            
            
        }
       
    }
    
    func testGetWeatherIfNoData() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
       
        weatherService.getWeather(url: fakeURL!) { (data) in
        //then
            XCTAssertNil(data)
        }
       
    }
    func testGetWeatherIfInconrrectResponse() {
        // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseKO, error: nil))
        //When
       
        weatherService.getWeather(url: fakeURL!) { (data) in
        //then
            XCTAssertNil(data)
        }
    }
    func testGetWeatherIfInconrrectData() {
            // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
            //When
           
            weatherService.getWeather(url: fakeURL!) { (data) in
            //then
                XCTAssertNil(data)
            }
       
    }

    func testGetWeatherIfNoErrorAndCorrectData() {
            // given
        let weatherService = WeatherService(session: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
            //When
           
            weatherService.getWeather(url: fakeURL!) { (data) in
            //then
                let name = "New York"
                XCTAssertEqual(name, weatherService.currentCity)
                XCTAssertNotNil(data)
            }
       
    }
}
