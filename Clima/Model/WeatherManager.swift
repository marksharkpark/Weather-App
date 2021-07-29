//
//  WeatherManager.swift
//  Clima
//
//  Created by Mark Park on 7/26/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel) // requirements
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=imperial&appid=4def1e95a0e661b74f84e643ed230e85"
    // using https for secure networking
    
    var delegate: WeatherManagerDelegate?
    
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
                    if let weather = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weather) // we need self bc we are within a closure
                    }
                }
            }
            //4. Start the task *Go to URL and retrieve data from URL
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temp: temp)
            return weather

            
        } catch {
            print(error)
            return nil
        }
    }
}
