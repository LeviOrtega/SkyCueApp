//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Levi Ortega on 7/30/21.
//

import Foundation
import Combine


class WeatherViewModel: ObservableObject {
    
    // wrapping
    private var weatherService: WeatherService!
    
    @Published var weather = WeatherMain()
    @Published var weatherDescription = WeatherDescription()
    
    init() {
        
        self.weatherService = WeatherService()
    }
    
    var temperature: String {
        if let temp = self.weather.temp {
            return String(format: "%.0f", temp)
        }
        else{
            return ""
        }
    }
    
    
    var humidity: String {
        if let humidity = self.weather.humidity {
            return String(format: "%.0f", humidity)
        }
        else{
            return ""
        }
    }
    
    
    var main: String {
        if let main = self.weatherDescription.mainDetails{
            return main
        }
        else {
            return ""
        }
    }
    
    var desc: String {
        if let desc = self.weatherDescription.details {
            return desc
        }
        else {
            return ""
        }
    }
    
    
    var cityName: String = ""
    
    
    func search() {
        // remove spaces
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            fetchWeather(by: city)
        }
    }
    
    private func fetchWeather(by city: String){
        self.weatherService.getWeather(city: city) { (weather, description) in
            if let weather = weather{
                
                // setting on main thread 
                DispatchQueue.main.async{
                self.weather = weather
                }
            }
            if let description = description {
                
                DispatchQueue.main.async {
                    self.weatherDescription = description
                }
            }
        }
    }
}
