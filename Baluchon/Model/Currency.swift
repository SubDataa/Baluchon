//
//  Currency.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import Foundation

class Currency {
  private let fixerURL = URL(string: "http://data.fixer.io/api/convert")!
  
    
  func getCurrency() {
        var request = URLRequest(url: fixerURL)
        request.httpMethod = "POST"
        let token = "?access_key=b5a0f33174f001702c59bee602752aa3"
        let currencyFrom = "&from=GBP"
        let currencyTo = "&to=JPY"
        let amount = "&amount=25"
        let body = "\(token)" + "\(currencyFrom)" + "\(currencyTo)" + "\(amount)"
        request.httpBody = body.data(using: .utf8)
      print(body)
    }
    
    

    
}
