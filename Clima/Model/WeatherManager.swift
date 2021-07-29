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
    // using https for secure networking
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)" // attaching cityname to API call
        self.performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1. Create url
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default) // creates our URL session object
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                // Convert JSON format into readible format.
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4. Start the task *Go to URL and retrieve data from URL
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
            print(decodedData.weather[0].main)
            print(decodedData.coord.lat)
            print(decodedData.coord.lon)
        } catch {
            print(error)
        }
        
    }
}
