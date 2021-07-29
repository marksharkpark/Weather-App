//
//  WeatherData.swift
//  Clima
//
//  Created by Mark Park on 7/29/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation



struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Decodable {
    let temp: Double
}

struct Weather : Decodable {
    let description: String
    let main: String
}

struct Coord: Decodable{
    let lon: Double
    let lat: Double
}



