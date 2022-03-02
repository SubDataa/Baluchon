//
//  Weather.swift
//  Baluchon
//
//  Created by Thibault Ballof on 30/11/2021.
//

import Foundation

// MARK: - DECODE JSON
struct DatasWeather: Codable {
    
    let coord : Coord
    let weather : [Weather]
    let main : Main
    let name : String

    struct Coord : Codable {
        let lon : Double
        let lat : Double
    }

    struct Weather : Codable {
        let description : String
        let icon : String
    }
    
    struct Main : Codable {
        let temp : Double
    } 
}

class WeatherService {
    static var shared = WeatherService()
    private init() {}
    // MARK: - VARIABLE FOR API CALL
    var temperatureC = 0
    var currentCity = ""
    var weatherIcon = ""
    var weatherDescription = ""
    var session = URLSession(configuration: .default)
    var task: URLSessionDataTask?
    var urlAPI = "https://api.openweathermap.org/data/2.5/weather?"
    var key = "&appid=b30e3845dbb1cb9ad75ce7da52752392"
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - API CONFIGURATION
    func getWeather(lat: String, lon: String, callback: @escaping (Bool, Data?) -> Void)  {
        var request = createWeatherURL(lat: lat, lon: lon)
        request.httpMethod = "GET"
        task?.cancel()
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
            guard let responseJSON = try? JSONDecoder().decode(DatasWeather.self, from: data) else {
                callback(false, nil)
                return
            }
            guard let weatherIcon = responseJSON.weather.first?.icon, let weatherDescription = responseJSON.weather.first?.description else  {
                    
                callback(false, nil)
                return
                }
                self.temperatureC = Int(responseJSON.main.temp - 273.15)
                self.currentCity = responseJSON.name
                self.weatherIcon = weatherIcon
                self.weatherDescription = weatherDescription
                callback(true, data)
            }
        }
        task?.resume()
   
    }
    
    func createWeatherURL(lat: String, lon: String) -> URLRequest{
        return URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?" + "lat=" + "\(lat)" + "&lon=" + "\(lon)" + "&appid=b30e3845dbb1cb9ad75ce7da52752392")!)
    }
    
    
}
