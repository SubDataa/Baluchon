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
    private let weather = WeatherService(session: .shared)
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
    
    //MARK: - API CALL
    private func showWeather() {
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?" + "lat=" + "\(latitude)" + "&lon=" + "\(longitude)" + "&appid=b30e3845dbb1cb9ad75ce7da52752392")
        weather.getWeather(url: weatherURL!) { (data) in
            self.temperatureText.text = "\(self.weather.temperatureC)"
            self.cityText.text = "\(self.weather.currentCity)"
            self.weatherDescription.text = "\(self.weather.weatherDescription)"
            self.icon = self.weather.weatherIcon
            self.weatherIcon.image = UIImage(named: "\(self.icon).png")
            self.degreeText.text = "°"
        }
        
        }
        
    private func showParisWeather() {
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=48.866667&lon=2.333333&appid=b30e3845dbb1cb9ad75ce7da52752392")
        weather.getWeather(url: weatherURL!) { (data) in
            self.parisTempLabel.text = "\(self.weather.temperatureC)"
            self.parisLabel.text = "\(self.weather.currentCity)"
            self.icon = self.weather.weatherIcon
            self.parisWeatherImg.image = UIImage(named: "\(self.icon).png")

        }
    }
    private func showNYWeather() {
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.7127281&lon=-74.0060152&appid=b30e3845dbb1cb9ad75ce7da52752392")
        weather.getWeather(url: weatherURL!) { (data) in
            self.nyTempLabel.text = "\(self.weather.temperatureC)"
            self.nyLabel.text = "\(self.weather.currentCity)"
            self.icon = self.weather.weatherIcon
            self.nyWeatherImg.image = UIImage(named: "\(self.icon).png")

        }
    }
    
}

