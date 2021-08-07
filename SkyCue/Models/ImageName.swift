//
//  ImageName.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

import Foundation
import SwiftUI


class ImageName: ObservableObject{
    
    var imageName: String = ""
  
 
    func correlateName(uncorrelatedName: String, isNightTime: Bool) -> String {
        
        let imageDict = ["Clear": "\(isNightTime ? "moon" : "sun.max")",
                         "Clouds": "\(isNightTime ? "cloud.moon" : "cloud.sun")",
                         "Rain": "\(isNightTime ? "cloud.moon.rain" : "cloud.sun.rain")",
                         "Thunderstorm" : "\(isNightTime ? "cloud.moon.bolt" : "cloud.sun.bolt")",
                         "Haze": "\(isNightTime ? "cloud.fog" : "sun.haze")",
                         "Fog": "\(isNightTime ? "cloud.fog" : "sun.haze")",
                         "Drizzle": "cloud.drizzle",
                         "Snow": "snow",
                         "Smoke": "smoke",
                         "Tornado": "tornado",
                         "Mist" : "cloud.fog.fill"
        
        ]
        
        
        
        // force unwrap to avoid "optional"
        
        if let val = imageDict[String(uncorrelatedName)] {
            imageName = val
        }
        else {
            // default image display
            imageName = "sun.min"
        }
        
        return imageName
    }
    
}
