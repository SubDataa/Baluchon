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
    private let weather = WeatherService()
    private var icon = ""
    private var firstLocation: CLLocation?
    
    @IBOutlet weak private var degreeText: UILabel!
    @IBOutlet weak private var cityText: UILabel!
    @IBOutlet weak private var temperatureText: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    
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
        weather.latitude = "\(location.coordinate.latitude)"
        weather.longitude = "\(location.coordinate.longitude)"
        firstLocation = location
        showWeather()
    }
    
    //MARK: - API CALL
    private func showWeather() {
        weather.getWeather { (data) in
            if data == nil {
                let alertController = UIAlertController(title: "Error", message: "Oops, something went wrong", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
            } else {
            self.temperatureText.text = "\(self.weather.temperatureC)"
            self.cityText.text = "\(self.weather.currentCity)"
            self.weatherDescription.text = "\(self.weather.weatherDescription)"
            self.icon = self.weather.weatherIcon
            self.weatherIcon.image = UIImage(named: "\(self.icon).png")
            self.degreeText.text = "°"
            }
        }
    }
}

