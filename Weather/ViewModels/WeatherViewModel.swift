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
  
    @Published var weatherMain = WeatherMain()
    @Published var weather = Weather()
    @Published var system = WeatherSystem()
    @Published var timezone: Int?

    
    init() {
        
        self.weatherService = WeatherService()
        
        
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
            return self.system.country!
        }
        else{
            return ""
        }
    }
    
    
    var sunrise: Double {
        if let sunrise = self.system.sunrise {
            return Double(self.system.sunrise!)
        }
        else{
            return 0.0
        }
    }
    
    var sunset: Double {
        if let sunset = self.system.sunset {
            return Double(self.system.sunset!)
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


    
    var cityName: String = ""
    
    
    func search() {
        // remove spaces
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            fetchWeather(by: city)
            
        }
        
        
    }
    
    //description
    private func fetchWeather(by city: String){
        self.weatherService.getWeather(city: city) { (main, weather, system, timezone) in
            if let main = main{
                
                // setting on main thread 
                DispatchQueue.main.async{
                self.weatherMain = main
                }
            }
            
            if weather[0] != nil{
                
                // setting on main thread
                DispatchQueue.main.async{
                    self.weather = weather[0]!
                }
            }
            
            
            if let sys = system{
                // setting on main thread
                DispatchQueue.main.async{
                    self.system = sys
                }
            }
           
        
        if let time = timezone{
            
            // setting on main thread
            DispatchQueue.main.async{
            self.timezone = time
            }
        }
        }
    }
}
