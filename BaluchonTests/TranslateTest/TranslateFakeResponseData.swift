//
//  TranslateFakeResponseData.swift
//  BaluchonTests
//
//  Created by Thibault Ballof on 03/03/2022.
//


import Foundation

class TranslateFakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    static let responseKO  = HTTPURLResponse(url: URL(string: "https://google.fr")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    class TranslateError: Error {}
    static let error = TranslateError()
    
    static var translateCorrectData: Data {
        let bundle = Bundle(for: TranslateFakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let translateIncorrectData = "error".data(using: .utf8)!
}

