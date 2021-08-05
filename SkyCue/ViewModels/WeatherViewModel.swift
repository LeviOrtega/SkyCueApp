//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Levi Ortega on 7/30/21.
//

import Foundation
import Combine
import SwiftUI


class WeatherViewModel: ObservableObject {
    
    // wrapping
    var weatherService: WeatherService!
    var forecastService: ForecastService!
  
    @Published var weatherMain = WeatherMain()
    @Published var weather = Weather()
    @Published var system = WeatherSystem()
    @Published var timezone: Int?
    @Published var coord = Coord()
    @Published var dailyForecast = [DailyForecast()]

    
    init() {
        
        self.weatherService = WeatherService()
        self.forecastService = ForecastService()
        
        
    }
    
    var temperature: String {
        if let temp = self.weatherMain.temp {
            return String(format: "%.0f", temp)
        }
        else{
            return ""
        }
    }
    
    
    var humidity: String {
        if let humidity = self.weatherMain.humidity {
            return String(format: "%.0f", humidity)
        }
        else{
            return ""
        }
    }
    
    
    var description: String {
        if self.weather.description != nil{
            return self.weather.description!
        }
        else{
            return ""
        }
    }
    
    
    var main: String {
        if self.weather.main != nil{
            return self.weather.main!
        }
        else{
            return ""
        }
    }
    
    
    var country: String {
        if let country = self.system.country {
            return country
        }
        else{
            return ""
        }
    }
    
    
    var sunrise: Double {
        if let sunrise = self.system.sunrise {
            return Double(sunrise)
        }
        else{
            return 0.0
        }
    }
    
    var sunset: Double {
        if let sunset = self.system.sunset {
            return Double(sunset)
        }
        else{
            return 0.0
        }
    }
    
    
    var timez: Int {
        if self.timezone != nil {
            return self.timezone!
        }
        else {
            return 0
        }
    }
    
    
    var lat: Double {
        if let l = self.coord.lat {
            return l
        }
        else{
            return 0.0
        }
    }
    
    var lon: Double {
        if let l = self.coord.lon {
            return l
        }
        else{
            return 0.0
        }
    }


    
    var cityName: String = ""
    
    
    func search() {
        // remove spaces
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
        fetchWeather(by: city)
        }
        if let cityLon = self.coord.lon , let cityLat = self.coord.lat {
             fetchForecast(lat: cityLat, lon: cityLon)
        }
        
        
        
    
    }
    
    private func fetchForecast(lat: Double, lon: Double){
        self.forecastService.getForecast(lat: lat, lon: lon) { dailyForecast in
            
            if let d = dailyForecast {
                DispatchQueue.main.async{
                    self.dailyForecast = d
                }
                
            }
            
        }
    }
    
    
    private func fetchWeather(by city: String) {
        self.weatherService.getWeather(city: city) { (mainCall, weatherCall, systemCall, timezoneCall, coordCall) in
            
            if mainCall != nil{
                
                // setting on main thread 
                DispatchQueue.main.async{
                self.weatherMain = mainCall!
                }
            }
            
            if weatherCall[0] != nil{
                
                // setting on main thread
                DispatchQueue.main.async{
                    self.weather = weatherCall[0]!
                }
            }
            
            
            if systemCall != nil{
                // setting on main thread
                DispatchQueue.main.async{
                    self.system = systemCall!
                }
            }
           
        
        if timezoneCall != nil{
            
            // setting on main thread
            DispatchQueue.main.async{
            self.timezone = timezoneCall!
            }
        }
            
        if coordCall != nil{
                
                // setting on main thread
                DispatchQueue.main.async{
                self.coord = coordCall!
                }
            }
            
            
            
            
        }
    }
}
