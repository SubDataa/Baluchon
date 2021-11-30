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

class Currency {
    
    var entryAmount = ""
    var convertResult = ""
    
    
    func getCurrency(completionHandler: @escaping (Data?) -> Void)  {
        let currencyFrom = "from=USD"
        let currencyTo = "&to=EUR"
        let amount = "&amount="
        let exchangerateURL = URL(string: "https://api.exchangerate.host/convert?" + "\(currencyFrom)" + "\(currencyTo)" + "\(amount)" + "\(entryAmount)")!
        var request = URLRequest(url: exchangerateURL)
        request.httpMethod = "GET"
        print(exchangerateURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let responseJSON = try? JSONDecoder().decode(Datas.self, from: data){
                            print(responseJSON)
                            self.convertResult = "\(responseJSON.result)"
                            completionHandler(data)
                        }
                    }
                }
            }
        }
        task.resume()
    }  
}
