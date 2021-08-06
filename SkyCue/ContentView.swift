//
//  ContentView.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel = WeatherViewModel()
    @ObservedObject var isNight: IsNight = IsNight()
    @ObservedObject var imageName: ImageName = ImageName()

    var location = Location(name: "Golden")
    var location2 = Location(name: "Arvada")
    
    @AppStorage("location", store: UserDefaults(suiteName: "group.com.leviortega.SkyCue"))
    var locationData: Data = Data()
    
    
    
    
    var body: some View {
        //MainView()
        
        Button("Button2"){
            saveLocation(location: location2)
        }
        
    }
    
    
    func saveLocation(location: Location){
        guard let locationData = try? JSONEncoder().encode(location) else {return}
        self.locationData = locationData
    }
    
}






struct MainView: View {
    
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
    
    func isAuthorized() -> Bool {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            return false
        }
        return true
    }
    
    init() {
        
        self.error = self.weatherVM.weatherService.error
        self.imageName.setNight(isNight: self.isNight)
        
    }
    
    var body: some View {
        ZStack{
            // error view is put on top of zstack
            ErrorAlert(displayError: $error.displayError, errorMessage: $error.errorMessage, errorType: $error.errorType)
            
            MainStackView(weatherVM: weatherVM, isNight: isNight, locationManager: locationManager, imageName: imageName, error: error, refreshViewOpacity: $refreshViewOpacity, textFieldViewOpacty: $textFieldViewOpacity, refreshed: $refreshed, backGroundColor: $backGroundColor)
                
            
            
            
        }.onAppear(){
            // if the user did not authorize location use, we will provide a random city to lookup upon app start
            if isAuthorized() == false {
                
                self.weatherVM.cityName = randomCity()
                self.weatherVM.search()
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
        // used for loading app
        .opacity(coverViewOpactity)
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
