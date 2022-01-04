//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit
//import MapKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let weather = WeatherService()
    var icon = ""
    
    
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var weatherDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        overrideUserInterfaceStyle = .dark
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        let firstLocation = locValue
        print(firstLocation)
        weather.latitude = "\(locValue.latitude)"
        weather.longitude = "\(locValue.longitude)"
        weather.getWeather { (data) in
            self.temperatureText.text = "\(self.weather.temperatureC)"
            self.cityText.text = "\(self.weather.currentCity)"
            self.weatherDescription.text = "\(self.weather.weatherDescription)"
        }
        
        icon = self.weather.weatherIcon
        weatherIcon.image = UIImage(named: "\(icon).png")
            
    }
    
  
   
    
    
}

