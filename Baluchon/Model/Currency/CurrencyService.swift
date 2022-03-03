//
//  Currency.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import Foundation

class CurrencyService {
    static var shared = CurrencyService()
    private init() {}
    
    var entryAmount = ""
    var task: URLSessionDataTask?
    
    func getCurrency(from: String, to: String, amount: String, callback: @escaping (Bool, CurrencyObject?) -> Void)  {
        var request = createCurrencyURL(from: from, to: to, amount: amount)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
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
    func createCurrencyURL(from: String, to: String, amount: String) -> URLRequest{
        return URLRequest(url: URL(string: "https://api.exchangerate.host/convert?" +  "\(from)" + "\(to)" + "\(amount)")!)
    }
    
    func createCurrencyObject(data: CurrencyData) -> CurrencyObject {
        let formatedResult = String(format:"%.2f", data.result)
        let result = formatedResult
        return CurrencyObject(result: result)
    }
}
