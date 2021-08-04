//
//  Locate.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/4/21.
//

import Foundation
import SwiftUI

// find current location and search for it to display upon app startup
func locate(locationManager: LocationManager, weatherVM: WeatherViewModel, error: Error, onUserDemand: Bool) {
    // on user demand relates to if the user was demanding the location and not a location call within the other blocks of code
    print("Locating..")
    
    guard let exposedLocation = locationManager.exposedLocation else {
        print("Unable to find current location.")
        if onUserDemand {
            error.errorMessage = "Unable to find current location. Make sure location services are enabled."
            error.errorType = "Location Error"
            error.displayError = true
        }
        return
    }
    
    locationManager.getPlace(for: exposedLocation) { placemark in
        guard let placemark = placemark else { return }
        if placemark.locality == nil {
            return
        }
        weatherVM.cityName = placemark.locality!
        weatherVM.search()
        print("Location found: \(weatherVM.cityName)")
    }
    
    
    
}
