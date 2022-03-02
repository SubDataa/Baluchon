//
//  Currency.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import Foundation

struct Datas: Codable {
    var result: Float 
}

class CurrencyService {
    static var shared = CurrencyService()
    private init() {}
    
    var entryAmount = ""
    var convertResult = ""
    var task: URLSessionDataTask?
    
    func getCurrency(from: String, to: String, amount: String, callback: @escaping (Bool, Data?) -> Void)  {
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
                guard let responseJSON = try? JSONDecoder().decode(Datas.self, from: data) else {
                    callback(false, nil)
                    return
                }
                            
                let formatedResult = String(format:"%.2f", responseJSON.result)
                self.convertResult = formatedResult
                callback(true, data)
                        }
        }
        task?.resume()
    }
    func createCurrencyURL(from: String, to: String, amount: String) -> URLRequest{
        return URLRequest(url: URL(string: "https://api.exchangerate.host/convert?" +  "\(from)" + "\(to)" + "\(amount)")!)
    }
}
