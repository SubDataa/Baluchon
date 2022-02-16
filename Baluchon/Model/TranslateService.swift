//
//  TranslateService.swift
//  Baluchon
//
//  Created by Thibault Ballof on 16/02/2022.
//

import Foundation
struct DatasTranslate : Codable {
    let text: [String]
}

class TranslateService {
    
    var entryText = ""
    var convertedText = ""
    
    func getTranslate(completionHandler: @escaping (Data?) -> Void)  {
        let escapedString = entryText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let translateURL = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20220216T080826Z.1b9ba0311cd3c71f.8a22f524d47cda660fd58d6454fb34e7909fea53&lang=fr-en&text=" + "\(escapedString)")!
        
        var request = URLRequest(url: translateURL)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                if let data = data, error == nil {
                    if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                        if let responseJSON = try? JSONDecoder().decode(DatasTranslate.self, from: data){
                            print(translateURL)
                            self.convertedText = responseJSON.text[0]
                            completionHandler(data)
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
}
