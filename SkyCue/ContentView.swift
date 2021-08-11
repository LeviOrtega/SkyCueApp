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
    @State var coverViewOpactity: Double = 1
    @State var mainViewOpacity: Double = 0
    @State var refreshViewOpacity: Double = 1
    @State var refreshTime: Double = 0.3
    @State var refreshed: Bool = false
    @State private var backGroundColor = Color.blue
    @State var menuOpen: Bool = false
    
    
    
    
    
    
    
    
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
            
            //LoadingView().opacity(coverViewOpactity)
            
            let detectDirectionalDrags = DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    //print(value.translation)
                    
                    if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                        weatherVM.cityName = randomCity()
                        refreshed.toggle()
                    }
                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                        weatherVM.cityName = randomCity()
                        refreshed.toggle()
                    }
                    //        else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                    //            print("up swipe")
                    //        }
                    //        else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                    //            print("down swipe")
                    //        }
                    //        else {
                    //            print("no clue")
                    //        }
                }
            
            // error view is put on top of zstack
            ErrorAlert(displayError: $error.displayError, errorMessage: $error.errorMessage, errorType: $error.errorType)
            
            
            
            MainStackBackground(weatherVM: weatherVM, isNight: isNight, locationManager: locationManager, imageName: imageName, error: error, refreshViewOpacity: $refreshViewOpacity, refreshed: $refreshed, backGroundColor: $backGroundColor, refreshTime: $refreshTime, menuOpen: self.$menuOpen)
                .ignoresSafeArea(.keyboard)
                .gesture(detectDirectionalDrags)
            
            SlideMenu(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: self.$refreshed, refreshViewOpacity: self.$refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime, menuOpen: self.$menuOpen, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
                .ignoresSafeArea(.keyboard)
            
            
            
            
        }//ZStack
        
        
        .onAppear(){
            
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
            
            if coverViewOpactity == 1{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 2), {
                        self.coverViewOpactity = 0
                        self.mainViewOpacity = 1
                        
                        
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
                    self.backGroundColor = Color(red: 50/255, green: 50/255, blue: 50/255)
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
        .onChange(of: weatherVM.locationNameList.count) { count in
            weatherVM.save()
        }
        // used for loading app
        .opacity(mainViewOpacity)
        
        
        
        
    }
    
}

struct LoadingView: View {
    
    
    var body: some View {
        
        Color(.systemBackground)
            
            
            .ignoresSafeArea(.all)
            .overlay(
                VStack(spacing: 0){
                    Image(systemName: "cloud")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .font(Font.largeTitle.weight(.ultraLight))
                    
                    
                    Text("Loading..")
                        .font(Font.subheadline.weight(.light))
                }
            )
            
            .foregroundColor(Color(.systemBlue))
        
        
    }
    
}





