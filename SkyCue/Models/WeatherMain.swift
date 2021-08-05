//
//  WeatherModel.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: WeatherMain
    let weather: [Weather]
    let sys: WeatherSystem
    let coord: Coord
    var timezone: Int?
}

struct Coord: Decodable {
    var lat: Double?
    var lon: Double?
}

struct WeatherMain: Decodable  {
    
    var temp: Double?
    var humidity: Double?

}

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    
}

struct WeatherSystem: Decodable {
    var sunrise: Int?
    var sunset: Int?
    var country: String?
}




