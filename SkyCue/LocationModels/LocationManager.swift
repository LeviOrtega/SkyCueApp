//
//  LocationManager.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

//https://medium.com/swift2go/swift-101-convert-coordinates-to-city-names-and-back-bdd2d40e0f8a


import Foundation
import CoreLocation
import SwiftUI


class LocationManager: NSObject, ObservableObject {
    
    @Published var changed: Bool = false
    private let locationManager = CLLocationManager()
    
    
    // - API
        public var exposedLocation: CLLocation? {
            return self.locationManager.location
        }
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
}


// Core Location Delegate
extension LocationManager: CLLocationManagerDelegate {
    
    
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        // any change to the authstatus will toggle a search of loation
        self.changed.toggle()
        
        switch status {
    
        case .notDetermined         : print("notDetermined")        // location permission not asked foryet
        case .authorizedWhenInUse   : print("authorizedWhenInUse")  // location authorized
        case .authorizedAlways      : print("authorizedAlways")    // location authorized
        case .restricted            : print("restricted")           // TODO: handle
        case .denied                : print("denied")               // TODO: handle
        }
    }
}

extension LocationManager {
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}
