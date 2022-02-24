//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 24/02/2022.
//

import Foundation
class WeatherFakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO  = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class WeatherError: Error {}
    static let error = WeatherError()
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let weatherIncorrectData = "error".data(using: .utf8)!
}

