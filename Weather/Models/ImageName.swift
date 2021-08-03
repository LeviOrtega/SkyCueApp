//
//  ImageName.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

import Foundation
import SwiftUI


struct ImageName {
    
    @ObservedObject var isNight: IsNight
 
    
    func correlateName(uncorrelatedName: String) -> String {
        
        let imageDict = ["Clear": "\(isNight.isNightTime ? "moon" : "sun.max")",
                         "Clouds": "\(isNight.isNightTime ? "cloud.moon" : "cloud.sun")",
                         "Rain": "\(isNight.isNightTime ? "cloud.moon.rain" : "cloud.sun.rain")",
                         "Thunderstorm" : "\(isNight.isNightTime ? "cloud.moon.bolt" : "cloud.sun.bolt")",
                         "Haze": "\(isNight.isNightTime ? "cloud.fog" : "sun.haze")",
                         "Fog": "\(isNight.isNightTime ? "cloud.fog" : "sun.haze")",
                         "Drizzle": "cloud.drizzle",
                         "Snow": "snow",
                         "Smoke": "smoke",
                         "Tornado": "tornado",
                         "Mist" : "cloud.fog.fill"
        
        ]
        
        var imageName: String = ""
        
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
