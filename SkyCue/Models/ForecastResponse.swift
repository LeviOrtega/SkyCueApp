//
//  ForecastMain.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/5/21.
//

import Foundation


struct ForecastResponse: Decodable {
    var daily: [DailyForecast]
    var hourly: [HourlyForecast]
}

struct DailyForecast: Decodable {
    //var dt: Int?
    var temp: Temp?
    var humidity: Int = 0
    var weather: [ForecastWeather]?
    //var rain: Double?
}

struct HourlyForecast: Decodable {
    var dt: Int?
    var temp: Double?
    var weather: [Weather]?

}

struct Temp: Decodable {
    var day, min, max, night: Double?
    var eve, morn: Double?
}

// MARK: - Weather
struct ForecastWeather: Decodable {
    var id: Int?
    var main, description, icon: String?
}
