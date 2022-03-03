//
//  TranslateService.swift
//  Baluchon
//
//  Created by Thibault Ballof on 16/02/2022.
//

import Foundation


class TranslateService {
    static var shared = TranslateService()
    private init() {}
    var task: URLSessionDataTask?
    var entryText = ""
    var convertedText = ""
    
    func getTranslate(callback: @escaping (Bool, TranslateObject?) -> Void)  {
        let escapedString = entryText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let translateURL = URL(string: "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20220216T080826Z.1b9ba0311cd3c71f.8a22f524d47cda660fd58d6454fb34e7909fea53&lang=fr-en&text=" + "\(escapedString)")!
        
        var request = URLRequest(url: translateURL)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async { [self] in
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard  let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslateData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let translate = createTranslateObject(data: responseJSON)
                callback(true, translate)
            }
        }
        
        task?.resume()
    }
    
    func createTranslateObject(data: TranslateData) -> TranslateObject {
        let translatedText = data.text[0]
        return TranslateObject(translatedText: translatedText)
    }
}
