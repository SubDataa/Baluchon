//
//  Weather.swift
//  Baluchon
//
//  Created by Thibault Ballof on 30/11/2021.
//

import Foundation

struct DatasWeather: Codable {
    
    let coord : Coord
    let weather : [Weather]
    let base : String
    let main : Main
    let visibility : Int
    let wind : Wind
    let clouds : Clouds
    let dt : Int
    let sys : Sys
    let timezone : Int
    let id : Int
    let name : String
    let cod : Int
    
    struct Coord : Codable {
        let lon : Double
        let lat : Double
    }
    struct Weather : Codable {
        let id : Int?
        let main : String
        let description : String
        let icon : String
    }
    struct Main : Codable {
        let temp : Double
        let feels_like : Double
        let temp_min : Double
        let temp_max : Double
        let pressure : Int
        let humidity : Int
    }
    struct Wind : Codable {
        let speed : Double
        let deg : Int
        let gust : Double
    }
    struct Clouds : Codable {
        let all : Int
    }
    struct Sys : Codable {
        let type : Int
        let id : Int
        let country : String
        let sunrise : Int
        let sunset : Int
    }
    
    
}

class WeatherService {
    
    var longitude = ""
    var latitude = ""
    var temperatureK = 0.0
    var temperatureC = 0
    var currentCity = ""
    var weatherIcon = ""
    var weatherDescription = ""
    
    func getWeather(completionHandler: @escaping (Data?) -> Void)  {
        let lat = "lat="
        let lon = "&lon="
        let key = "&appid=b30e3845dbb1cb9ad75ce7da52752392"
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?" + "\(lat)" + "\(latitude)" + "\(lon)" + "\(longitude)" + "\(key)")!
        var request = URLRequest(url: weatherURL)
        request.httpMethod = "GET"
        print(weatherURL)
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, error == nil, let response = response as? HTTPURLResponse,
                   response.statusCode == 200,
                   let responseJSON = try? JSONDecoder().decode(DatasWeather.self, from: data){
                    self.temperatureC = Int(responseJSON.main.temp - 273.15)
                    self.currentCity = responseJSON.name
                    
                    if let weatherIcon = responseJSON.weather.first?.icon, let weatherDescription = responseJSON.weather.first?.description  {
                        self.weatherIcon = weatherIcon
                        self.weatherDescription = weatherDescription
                        
                    }
                    
                    completionHandler(data)
                }
                
                
            }
        }
        task.resume()
    }
    
    
}
