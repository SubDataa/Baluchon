//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit
import MapKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let weather = WeatherService()
    var icon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        weather.latitude = "\(locValue.latitude)"
        weather.longitude = "\(locValue.longitude)"
        weather.getWeather { (data) in
            self.temperatureText.text = "\(self.weather.temperatureC) °C"
            self.cityText.text = "\(self.weather.currentCity)"
        }
        
        icon = self.weather.weatherIcon
        let url = URL(string: "https://openweathermap.org/img/w/" + "\(icon)" + ".png")!
        
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                weatherIcon.image = UIImage(data: data)
            }
        
    }
    
    
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    //http://openweathermap.org/img/w/ + .png
    
    
}

