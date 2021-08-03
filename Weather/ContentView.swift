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
    var imageName: ImageName?
    
    // before the app loads, we have a cover view that hides all of the content
    @State var coverViewOpactity: Double = 0
    @State var refreshViewOpacity: Double = 1
    
    @State var refreshed: Bool = false
    
    @State private var backGroundColor = Color.blue
    
    
    
    
    // find current location and search for it to display upon app startup
    func locate() {
        guard let exposedLocation = self.locationManager.exposedLocation else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        self.locationManager.getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            if placemark.locality == nil {
                return
            }
            self.weatherVM.cityName = placemark.locality!
            self.weatherVM.search()
        }
        
    }
    
    init() {
        
        self.error = self.weatherVM.weatherService.error
        self.imageName = ImageName(isNight: self.isNight)
        
    }
    var body: some View {
        
        ZStack{
            // error view is put on top of zstack 
            ErrorAlert(displayError: $error.displayError, errorMessage: $error.errorMessage, errorType: $error.errorType)
            
            VStack(alignment: .center){
                Spacer()
                
                
                HStack{
                    
                    VStack(alignment: .center){
                        ImageView(weatherVM: self.weatherVM, imageName: imageName!.correlateName(uncorrelatedName: self.weatherVM.main))
                        DescriptionView(weatherVM: self.weatherVM)
                        
                    }.padding(.all)
                    .opacity(0.8)
                    
                    
                    HStack{
                        TimeImageView()
                        TimeView(weatherVM: self.weatherVM)
                    }
                    .opacity(0.8)
                    .font(Font.headline.weight(.light))
                    .padding(.leading)
                    
                }
                .opacity(refreshViewOpacity)
                
                TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight)
                
                InfoView(weatherVM: weatherVM)
                    .opacity(refreshViewOpacity)
                
                Spacer()
                
                HStack{
                    
                    Button(action: {
                        locate()
                        getTimeInfo(isNight: self.isNight, weatherVM: self.weatherVM)

                           self.refreshed.toggle()
                    }){
                        Image(systemName: "location")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        getTimeInfo(isNight: self.isNight, weatherVM: self.weatherVM)
                        self.weatherVM.search()
                        self.refreshed.toggle()
                    }){
                        Image(systemName: "arrow.clockwise")
                        
                    }
                    .padding(.trailing)
                }
                .opacity(0.7)
                .font(Font.headline.weight(.light))
                
           
                
                
                
                
                
                
                
                
                
                
                
                
            }
            .foregroundColor(.white)
            .offset(x: 0, y: -25)
            .onAppear(){
                // on app startup we wish to look for the location of the user and display their current city's weather
                locate()
                
            }
            .onChange(of: self.locationManager.changed) { change in
                // when the authorization for location managing changes, immediately attempt to locate location
                // if auth is not allowing us to find location, search will do nothing
                // this is only used for when the auth is initially changed after downloading the app
                
                locate()
                
            }
            .onChange(of: self.refreshed){toggle in
                getTimeInfo(isNight: self.isNight, weatherVM: self.weatherVM)
                if toggle {
                    // if the cityName changed we need to refresh
                    withAnimation(.easeInOut(duration: 1), {
                        self.refreshViewOpacity = 0
                        self.refreshed.toggle()
                    })
                }
                
                else {
                    
                    // after the initial animation we want to animate back in
                    withAnimation(.easeInOut(duration: 1), {
                        self.refreshViewOpacity = 1
                        
                    })
                    
                }
                
            }
            .onChange(of: self.weatherVM.sunset){ change in
                self.refreshed.toggle()
                
                
            }
            // fading between colors depending on night/day time of location searched
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .onChange(of: isNight.isNightTime){ change in
                if isNight.isNightTime {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.backGroundColor = Color.black
                    }
                }
                else {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.backGroundColor = Color.blue
                    }
                }
            }
            
            .background(self.backGroundColor)
            
            
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .opacity(isNight.isNightTime ? 0.9 : 0.8)
            
            
        }.onAppear(){
            if isAuthorized() == false {
                
                self.weatherVM.cityName = randomCity()
                self.weatherVM.search()
            }
        }
        // we want out view to display only when the data has been loaded all the way
        .onChange(of: self.weatherVM.cityName){ change in
            withAnimation(.easeInOut(duration: 0.5), {
                self.coverViewOpactity = 1
                
            })
            
            
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
