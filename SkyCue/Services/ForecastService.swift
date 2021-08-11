//
//  ForecastService.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/5/21.
//

import Foundation
import Combine
import SwiftUI

class ForecastService{
    
    // instance of error we care about
    
  
    
    func getForecast(lat: Double, lon: Double,
                    
                    completion: @escaping ([DailyForecast]?, [HourlyForecast]?, CurrentForecast?) -> ())
    
    {
        
        
        
        // api call
        // we do not care about current, minutely, or hourly
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=df67420b27963698a63e86afcf794f4e&units=imperial")
        
        //guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,alerts&appid=bd9fb8bfb9b56f8e978f9b4bfffb5092&units=imperial")
        
        
        
        
        else {
            completion(nil, nil, nil)
            
            return
        }
        
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil
            else {
                completion(nil, nil, nil)

                return
            }
            
            let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data)
            
            if let value = forecastResponse {
                
                let dailyForecast = value.daily
                let hourlyForecast = value.hourly
                let currentForecast = value.current
                completion(dailyForecast, hourlyForecast, currentForecast)
                
            }else{
                completion(nil, nil, nil)

                
            }
            
            
        }.resume()
        
    }
    
}
