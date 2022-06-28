//
//  Currency.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import Foundation

class CurrencyService {
    // MARK: - Singleton
    static var shared = CurrencyService()
    private init() {}
    var task: URLSessionDataTask?
    
    // MARK: - VARIABLE FOR API CALL
    var entryAmount = ""
    
    // MARK: - INJECT DEPENDENCY
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - API CONFIGURATION
    func getCurrency(from: String, to: String, amount: String, callback: @escaping (Bool, CurrencyObject?) -> Void)  {
        var request = createCurrencyURL(from: from, to: to, amount: amount)
        request.httpMethod = "GET"
        
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(CurrencyData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let currency = self.createCurrencyObject(data: responseJSON)
                callback(true, currency)
            }
        }
        task?.resume()
    }
    // MARK: - CREATE URL FOR API CALL
    func createCurrencyURL(from: String, to: String, amount: String) -> URLRequest{
        return URLRequest(url: URL(string: "https://api.exchangerate.host/convert?" +  "\(from)" + "\(to)" + "\(amount)")!)
    }
    
    // MARK: - CREATE CURRENCY OBJECT
    func createCurrencyObject(data: CurrencyData) -> CurrencyObject {
        let formatedResult = String(format:"%.2f", data.result)
        let result = formatedResult
        return CurrencyObject(result: result)
    }
}
