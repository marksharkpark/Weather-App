//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // comes with location manager

class WeatherViewController: UIViewController {
    
        
// The Text Field Delegate allows us to manage editing and validation of a text in a text field object
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager() // grabs crrent location from the phone
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // requests User for permission
        locationManager.requestLocation() // after obtaining location fix, it calls the delegate didUpdateLocation method with result
        
        
        weatherManager.delegate = self // set the current class as the delegate
        searchTextField.delegate = self // the text field can communicate with the view controller by setting the view controller as the delegate
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // dismisses the keyboard
    }
    
    // Asks the delegate if the text field should process the pressing of the return key/button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) // dismisses the keyboard
        return true // allow the text field to be allowed to return
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else {
            textField.placeholder = "Type something Here!" // changes the transparency pre-set text field word
            return false
        }
    }
    
    // Clearing text field text
    func textFieldDidEndEditing(_ textField: UITextField) {
        //Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK: - Weather Manager Delegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async{
            self.temperatureLabel.text = weather.tempatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error){
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
