//
//  CurrencyFakeResponseData.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//
import Foundation

class CurrencyFakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO  = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class CurrencyError: Error {}
    static let error = CurrencyError()
    
    static var currencyCorrectData: Data {
        let bundle = Bundle(for: CurrencyFakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let currencyIncorrectData = "error".data(using: .utf8)!
}

