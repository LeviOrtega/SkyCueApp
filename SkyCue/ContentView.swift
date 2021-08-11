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
    @State var refreshTime: Double = 0.3
    @State var refreshed: Bool = false
    @State private var backGroundColor = Color.blue
    
    func isAuthorized() -> Bool {
        // check to see if users allowed for location services
        guard let exposedLocation = self.locationManager.exposedLocation else {
            return false
        }
        return true
    }
    
    
    func refresh(){
        print("Refreshing")
        weatherVM.search()
        getTimeInfo(isNight: self.isNight, weatherVM: self.weatherVM, dateString: getTime(UTC: weatherVM.timez))
    }
    
    init() {
        
        // get the error object initialized in the weather service class
        self.error = self.weatherVM.weatherService.error

    }
    
    var body: some View {
        ZStack{
            // error view is put on top of zstack
            ErrorAlert(displayError: $error.displayError, errorMessage: $error.errorMessage, errorType: $error.errorType)
            
            MainStackBackground(weatherVM: weatherVM, isNight: isNight, locationManager: locationManager, imageName: imageName, error: error, refreshViewOpacity: $refreshViewOpacity, refreshed: $refreshed, backGroundColor: $backGroundColor, refreshTime: $refreshTime)
                
            
            
            
        }.onAppear(){
            print("hi")
            // if the user did not authorize location use, we will provide a random city to lookup upon app start
            if isAuthorized() == false {
                
                self.weatherVM.cityName = randomCity()
                self.weatherVM.search()
            }
            
            else {
                // on app startup we wish to look for the location of the user and display their current city's weather
                
                locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: false)
                refreshed.toggle()
            }
        }
        // we want out view to display only when the data has been loaded all the way
        .onChange(of: self.weatherVM.cityName){ change in
            
            if coverViewOpactity == 0{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 2), {
                        self.coverViewOpactity = 1
                        
                    })
                }
            }
            
        }
    
        .onChange(of: self.locationManager.changed) { change in
            // when the authorization for location managing changes, immediately attempt to locate location
            // if auth is not allowing us to find location, search will do nothing
            // this is only used for when the auth is initially changed after downloading the app
            
            locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: false)
            refreshed.toggle()
            
        }
        .onChange(of: self.weatherVM.sunset){ change in
            // if the sunset time changes, we need to check to see if we need to change night / day colors
            refreshed.toggle()
        }
        // fading between colors depending on night/day time of location searched
        .onChange(of: isNight.isNightTime){ change in
            
            
            if isNight.isNightTime {
                withAnimation(.easeInOut(duration: refreshTime)) {
                    self.backGroundColor = Color.black //Color(red: 255/255, green: 25/255, blue: 25/255)
                }
            }
            else {
                withAnimation(.easeInOut(duration: refreshTime)) {
                    self.backGroundColor = Color.blue
                }
            }
        }
        .onChange(of: self.refreshed){toggle in
            
            // if the cityName changed we need to refresh
            withAnimation(.easeInOut(duration: refreshTime), {
                self.refreshViewOpacity = 0
                
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 0.2) {
                
                refresh()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 1) {
                
                // after the initial animation we want to animate back in
                withAnimation(.easeInOut(duration: refreshTime), {
                    self.refreshViewOpacity = 1
                    
                })
            }
            
            
        }
        
        // used for loading app
        .opacity(coverViewOpactity)
    }
    
}




