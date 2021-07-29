//
//  WeatherModel.swift
//  Clima
//
//  Created by Mark Park on 7/29/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temp: Double
    
    var aProperty: Int{
        return 2 + 5
    } // aProperty = 7
    
    var tempatureString: String{
        return String(format: "%0.1f", temp)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }

}
