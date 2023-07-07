//
//  WeatherModel.swift
//  clima
//
//  Created by Kodeeshwari Solanki on 2023-07-06.
//

import Foundation

struct WeatherModel{
    let cityName : String
    let temperature : Double
    let conditionID : Int
    let weatherDesc : String
    
    init(cityName: String, temperature: Double, conditionID: Int, weatherDesc: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.conditionID = conditionID
        self.weatherDesc = weatherDesc
    }
   
    
    var description : String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
