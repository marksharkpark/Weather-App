//
//  WeatherManager.swift
//  Clima
//
//  Created by Mark Park on 7/26/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=4def1e95a0e661b74f84e643ed230e85"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)" // attaching cityname to API call
        print(urlString)
    }
}
