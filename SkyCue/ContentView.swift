//
//  ContentView.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var weatherVM: WeatherViewModel = WeatherViewModel()
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var error: Error = Error()
    @ObservedObject var isNight: IsNight = IsNight()
    @ObservedObject var imageName: ImageName = ImageName()
    @State var coverViewOpactity: Double = 0
    @State var refreshViewOpacity: Double = 1
    @State var textFieldViewOpacity: Double = 0.7
    @State var refreshed: Bool = false
    @State private var backGroundColor = Color.blue
    
    
    
    init() {
        
        self.error = self.weatherVM.weatherService.error
        self.imageName.setNight(isNight: self.isNight)
        
    }
    
    
    var body: some View {
        
        ZStack{
            // error view is put on top of zstack 
            ErrorAlert(displayError: $error.displayError, errorMessage: $error.errorMessage, errorType: $error.errorType)
            
            MainStackView(weatherVM: weatherVM, isNight: isNight, locationManager: locationManager, imageName: imageName, refreshViewOpacity: $refreshViewOpacity, textFieldViewOpacty: $textFieldViewOpacity, refreshed: $refreshed, backGroundColor: $backGroundColor)
            
        }.onAppear(){
            // if the user did not authorize location use, we will provide a random city to lookup upon app start
            if isAuthorized() == false {
                
                self.weatherVM.cityName = randomCity()
                self.weatherVM.search()
            }
        }
        // we want out view to display only when the data has been loaded all the way
        .onChange(of: self.weatherVM.cityName){ change in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 2), {
                    self.coverViewOpactity = 1
                    
                })
            }
            
        }
        // used for loading app
        .opacity(coverViewOpactity)
    }
    
    
    func isAuthorized() -> Bool {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            return false
        }
        return true
    }
}


// find current location and search for it to display upon app startup
func locate(locationManager: LocationManager, weatherVM: WeatherViewModel) {
    
    
    guard let exposedLocation = locationManager.exposedLocation else {
        print("*** Error in \(#function): exposedLocation is nil")
        return
    }
    
    locationManager.getPlace(for: exposedLocation) { placemark in
        guard let placemark = placemark else { return }
        if placemark.locality == nil {
            return
        }
        weatherVM.cityName = placemark.locality!
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
