//
//  Weather.swift
//  Baluchon
//
//  Created by Thibault Ballof on 30/11/2021.
//

import Foundation

class WeatherService {
    // MARK: - Singleton
    static var shared = WeatherService()
    private init() {}
    var task: URLSessionDataTask?
    
    // MARK: - INJECT DEPENDENCY
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK: - API CONFIGURATION
    func getWeather(lat: String, lon: String, callback: @escaping (Bool, WeatherObject?) -> Void)  {
        var request = createWeatherURL(lat: lat, lon: lon)
        request.httpMethod = "GET"
        //task?.cancel()
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
                guard let responseJSON = try? JSONDecoder().decode(WeatherData.self, from: data) else {
                    callback(false, nil)
                    return
                }
                
                let weather = self.createWeatherObject(data: responseJSON)
                callback(true, weather)
            }
        }
        task?.resume()
        
    }
    
    // MARK: - CREATE URL FOR API CALL
    func createWeatherURL(lat: String, lon: String) -> URLRequest{
        return URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?" + "lat=" + "\(lat)" + "&lon=" + "\(lon)" + "&appid=b30e3845dbb1cb9ad75ce7da52752392")!)
    }
    // MARK: - CREATE WEATHER OBJECT
    func createWeatherObject(data: WeatherData) -> WeatherObject {
        let temp = "\(Int(data.main.temp - 273.15))"
        let city = data.name
        let icon = data.weather[0].icon
        let description = data.weather[0].description
        
        return WeatherObject(temperature: temp, cityName: city, weatherDescription: description, iconIdentifier: icon)
    }
}
