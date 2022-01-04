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
    var firstLocation: CLLocation?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
      
    }
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       if let location = manager.location, let distance =  firstLocation?.distance(from: location), distance > 1000 {
          updateCoor(location: location)
        } else if let location = manager.location, firstLocation == nil  {
            updateCoor(location: location)
        }  
    }
   
    func updateCoor(location: CLLocation) {
        weather.latitude = "\(location.coordinate.latitude)"
        weather.longitude = "\(location.coordinate.longitude)"
        firstLocation = location
        showWeather()
    }
    
    func showWeather() {
        
        weather.getWeather { (data) in
            self.temperatureText.text = "\(self.weather.temperatureC)"
            self.cityText.text = "\(self.weather.currentCity)"
            self.weatherDescription.text = "\(self.weather.weatherDescription)"
            self.icon = self.weather.weatherIcon
            self.weatherIcon.image = UIImage(named: "\(self.icon).png")
        }
        
       
    }
   
    
    
}

