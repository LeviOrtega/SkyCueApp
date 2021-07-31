//
//  WeatherService.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import Foundation


class WeatherService {
    
    
    func getWeather(city: String, completion1: @escaping (WeatherMain?, WeatherDescription?) -> ()){
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=bd9fb8bfb9b56f8e978f9b4bfffb5092")
        
        else {
            completion1(nil, nil)
            
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            guard let data = data, error == nil else {
                completion1(nil, nil)
                
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            
            if let value = weatherResponse {
                let weatherMain = weatherResponse?.main
                let weatherDescription = weatherResponse?.weather
                completion1(weatherMain, weatherDescription)
                
            }else{
                completion1(nil, nil)
                
            }
            
        }.resume()
        
    }
    
}
