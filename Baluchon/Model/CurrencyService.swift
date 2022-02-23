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
    var entryAmount = ""
    var convertResult = ""
    
    
    func getCurrency(url: URL, completionHandler: @escaping (Data?) -> Void)  {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let responseJSON = try? JSONDecoder().decode(Datas.self, from: data){
                            
                            let formatedResult = String(format:"%.2f", responseJSON.result)
                            self.convertResult = formatedResult
                            completionHandler(data)
                        }
                    }
                }
            }
        }
        task.resume()
    }  
}
