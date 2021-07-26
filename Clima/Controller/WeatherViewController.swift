//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate{
// The Text Field Delegate allows us to manage editing and validation of a text in a text field object
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self // the text field can communicate with the view controller by setting the view controller as the delegate
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true) // dismisses the keyboard
        print(searchTextField.text!)
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

