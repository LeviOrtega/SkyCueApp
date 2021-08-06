//
//  WeatherService.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import Foundation
import Combine
import SwiftUI

class WeatherService{
    
    // instance of error we care about 
    @ObservedObject var error = Error()
    
    func getWeather(city: String, completion:
                        @escaping (WeatherMain?, [Weather?], WeatherSystem?, Int?, Coord?) -> ()){
        
        
        
        // api call
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=bd9fb8bfb9b56f8e978f9b4bfffb5092&units=imperial")
        
        else {
            
            self.error.displayError = true
            self.error.errorMessage = "Unable to connect to servers, please connect to a network."
            self.error.errorType = "Network Error"
            completion(nil, [nil], nil, nil, nil)
            
            return
        }
        
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil
            else {
                
                self.error.displayError = true
                self.error.errorMessage = "Unable to connect to servers, please connect to a network."
                self.error.errorType = "Network Error"
                completion(nil, [nil], nil, nil, nil)

                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let value = weatherResponse {
                let weatherMain = weatherResponse?.main
                let weather = weatherResponse?.weather
                let weatherSystem = weatherResponse?.sys
                let timezone = weatherResponse?.timezone
                let coord = weatherResponse?.coord
                completion(weatherMain, weather!, weatherSystem, timezone, coord)
                
                
            }else{
                
                
                if city != ""{
                    self.error.errorMessage = "Unable to find entered location, please enter in another location."
                    self.error.errorType = "Location Error"
                    self.error.displayError = true
                }
                
                
                completion(nil, [nil], nil, nil, nil)

                
            }
            
            
        }.resume()
        
    }
    
}
