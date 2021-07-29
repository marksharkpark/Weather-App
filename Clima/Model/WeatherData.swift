//
//  WeatherData.swift
//  Clima
//
//  Created by Mark Park on 7/29/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather : Codable {
    let id: Int
    let description: String
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}



