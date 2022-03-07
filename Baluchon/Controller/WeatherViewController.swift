//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Thibault Ballof on 29/11/2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - VARIABLE FOR UI & CLASS INSTANCE
    private let locationManager = CLLocationManager()
    
    
    private var icon = ""
    private var firstLocation: CLLocation?
    private var latitude = ""
    private var longitude = ""
    
    @IBOutlet weak private var degreeText: UILabel!
    @IBOutlet weak private var cityText: UILabel!
    @IBOutlet weak private var temperatureText: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var parisLabel: UILabel!
    @IBOutlet weak var parisTempLabel: UILabel!
    @IBOutlet weak var nyTempLabel: UILabel!
    @IBOutlet weak var nyLabel: UILabel!
    @IBOutlet weak var nyWeatherImg: UIImageView!
    @IBOutlet weak var parisWeatherImg: UIImageView!
    
    //MARK: - CLLocationManager INSTANCE & DARK MODE SETTING
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request the user's authorization to access the location
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        overrideUserInterfaceStyle = .dark
        showParisWeather()
        showNYWeather()
    }
    
    //MARK: - OPEN ALERT WHEN USER DECLINE LOCATION
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .denied else { return }
        let alertController = UIAlertController(title: "Location Permission Required", message: "We need to access your location to run our application. Please authorize the location in the settings", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: - GET USER LOCATION
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location, let distance =  firstLocation?.distance(from: location), distance > 1000 {
            updateCoor(location: location)
        } else if let location = manager.location, firstLocation == nil  {
            updateCoor(location: location)
        }
    }
    
    //MARK: - UPDATING COORD FOR API CALL
    private func updateCoor(location: CLLocation) {
        latitude = "\(location.coordinate.latitude)"
        longitude = "\(location.coordinate.longitude)"
        firstLocation = location
        showWeather()
        
    }
    
    //MARK: - API CALL FOR LOCATION
    private func showWeather() {
        WeatherService.shared.getWeather(lat: latitude, lon: longitude) { (sucess, weather) in
            if sucess {
                self.updateWeatherView(from: weather!, icon: self.weatherIcon, temp: self.temperatureText, city: self.cityText, description: self.weatherDescription)
                self.degreeText.text = "°"
            }
            
        }
        
    }
    //MARK: - API CALL FOR PARIS
    private func showParisWeather() {
        WeatherService.shared.getWeather(lat: "48.866667", lon: "2.333333") { (sucess, weather) in
            if sucess {
                self.updateWeatherView(from: weather!, icon: self.parisWeatherImg, temp: self.parisTempLabel, city: self.parisLabel, description: nil)
            }
            
        }
    }
    //MARK: - API CALL FOR NY
    private func showNYWeather() {
        WeatherService.shared.getWeather(lat: "40.7127281", lon: "-74.0060152") { (sucess, weather) in
            if sucess {
                self.updateWeatherView(from: weather!, icon: self.nyWeatherImg, temp: self.nyTempLabel, city: self.nyLabel, description: nil)
            }
            
        }
    }
    //MARK: - UPDATE WEATHER VIEW
    private func updateWeatherView(from data: WeatherObject, icon: UIImageView, temp: UILabel, city: UILabel, description: UILabel?) {
        temp.text = "\(data.temperature)"
        city.text = "\(data.cityName)"
        description?.text = "\(data.weatherDescription)"
        icon.image = UIImage(named: "\(data.iconIdentifier).png")
        
        
    }
    
}

