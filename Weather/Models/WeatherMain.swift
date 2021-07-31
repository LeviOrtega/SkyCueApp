//
//  WeatherModel.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: WeatherMain
    let weather: WeatherDescription
}

struct WeatherMain: Decodable  {
    
    var temp: Double?
    var humidity: Double?
    
  
    
}

struct WeatherDescription: Decodable {
    
    var mainDetails: String?
    var details: String?
    
}
