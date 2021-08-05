//
//  ForecastMain.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/5/21.
//

import Foundation


// MARK: - Welcome
struct ForecastResponse: Decodable {
    var daily: [DailyForecast]
}

// MARK: - Daily
struct DailyForecast: Decodable {
    var dt: Int
    var temp: Temp
    var humidity: Int
    var weather: [ForecastWeather]
    var rain: Double
}

// MARK: - Temp
struct Temp: Decodable {
    var day, min, max, night: Double
    var eve, morn: Double
}

// MARK: - Weather
struct ForecastWeather: Decodable {
    var id: Int
    var main, weatherDescription, icon: String
}
