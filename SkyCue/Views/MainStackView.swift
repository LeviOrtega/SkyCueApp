//
//  MainStackView.swift
//  Weather
//
//  Created by Levi Ortega on 8/3/21.
//

import Foundation
import SwiftUI



struct MainStackView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var imageName: ImageName
    @ObservedObject var error: Error
    @Binding var refreshViewOpacity: Double
    @Binding var textFieldViewOpacty: Double
    @Binding var refreshed: Bool
    @Binding var backGroundColor: Color
    
    var refreshTime: Double = 0.3
    
    var body: some View{
        ZStack{
            MainContentView(weatherVM: self.weatherVM, isNight: self.isNight, locationManager: self.locationManager, imageName: self.imageName, error: self.error, refreshViewOpacity: self.$refreshViewOpacity, textFieldViewOpacty: self.$textFieldViewOpacty, refreshed: self.$refreshed, backGroundColor: self.$backGroundColor)
               
                .padding(.init(top: 20, leading: 5, bottom: 5, trailing: 5) )
            
            
        }.foregroundColor(.white)
        .offset(x: 0, y: -25)
        .onAppear(){
            // on app startup we wish to look for the location of the user and display their current city's weather
            
            locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: false)
            refreshed.toggle()
            
            
        }
        .onChange(of: self.locationManager.changed) { change in
            // when the authorization for location managing changes, immediately attempt to locate location
            // if auth is not allowing us to find location, search will do nothing
            // this is only used for when the auth is initially changed after downloading the app
            
            locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: false)
            refreshed.toggle()
            
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
        .onChange(of: self.weatherVM.sunset){ change in
            refreshed.toggle()
        }
        // fading between colors depending on night/day time of location searched
        .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .onChange(of: isNight.isNightTime){ change in
            
            //print(isNight.isNightTime)
            
            
            if isNight.isNightTime {
                withAnimation(.easeInOut(duration: refreshTime)) {
                    self.backGroundColor = Color(red: 25/255, green: 25/255, blue: 25/255)
                }
            }
            else {
                withAnimation(.easeInOut(duration: refreshTime)) {
                    self.backGroundColor = Color.blue
                }
            }
        }
        
        .background(self.backGroundColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .opacity(isNight.isNightTime ? 0.9 : 0.8)
        
    }
    
    
    
    func refresh(){
        print("Refreshing")
        weatherVM.search()
        getTimeInfo(isNight: self.isNight, weatherVM: self.weatherVM, dateString: getTime(UTC: weatherVM.timez))
    }
    
}


struct MainContentView: View {
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var imageName: ImageName
    @ObservedObject var error: Error
    @Binding var refreshViewOpacity: Double
    @Binding var textFieldViewOpacty: Double
    @Binding var refreshed: Bool
    @Binding var backGroundColor: Color
    
    
    var body: some View {
        
        VStack(alignment: .center){
            
            Spacer()
            
            ZStack{
            //ScrollView{
            HStack{
                
                VStack(alignment: .center, spacing: 0){
                    ImageView(weatherVM: self.weatherVM, imageName: imageName.correlateName(uncorrelatedName: self.weatherVM.main, isNightTime: self.isNight.isNightTime))
                    Text(self.weatherVM.temperature == "" ? ""
                            :"\(self.weatherVM.temperature) \u{00B0}F")
                        .font(Font.largeTitle.weight(.light))
                    DescriptionView(weatherVM: self.weatherVM)
                    
                }.scaledToFill()
                .padding(.leading, 10)
                .opacity(0.8)
            
                Spacer()
                    
                HStack{
                    TimeImageView()
                    TimeView(weatherVM: self.weatherVM)
                }
                
                .font(Font.headline.weight(.light))
                .scaledToFill()
                .padding(.trailing, 15)
                .opacity(0.8)
                
                
            }
    
            
            .opacity(refreshViewOpacity)
            .padding(35)
            
            }
            .background(backGroundColor)
            .cornerRadius(50)
            
            
            
            ZStack{
                HStack{
                    Image(systemName: "magnifyingglass").padding(20)
                        .opacity(0.9)
                        .font(Font.title.weight(.light))
                    Spacer()
                }

                TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, textFieldViewOpacty: $textFieldViewOpacty, backGroundColor: self.$backGroundColor)
                
                    
                   
                    
                
            }
            .background(self.backGroundColor)
            .cornerRadius(100)
            
            
            
            
            
            ForecastView(weatherVM: self.weatherVM, imageName: self.imageName, isNight: self.isNight, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
            
            
            
            //}
            
            Spacer()
            
            RefreshAndLocateView(locationManager: locationManager, weatherVM: weatherVM, isNight: isNight, error: error, refreshed: $refreshed, textFieldViewOpacty: $textFieldViewOpacty, backGroundColor: self.$backGroundColor)
            
        }.padding(.top, 50)
        
        
        
    }
    
}



struct RefreshAndLocateView: View {
    
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var error: Error
    
    @Binding var refreshed: Bool
    @Binding var textFieldViewOpacty: Double
    @Binding var backGroundColor: Color

    
    let refreshTime = 0.3
    
    var body: some View {
        HStack{
           
            ZStack{
            Button(action: {
                // this is the only time that we use the onUserDemand as its when the user actually presses the locate button
                withAnimation(.easeInOut(duration: refreshTime)) {
                    textFieldViewOpacty = 0
                }
                
                // wait for text field text fade
                DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime) {
                    
                    locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: true)
                    refreshed.toggle()
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 1) {
                    
                    // after the initial animation we want to animate back in
                    withAnimation(.easeInOut(duration: refreshTime), {
                        textFieldViewOpacty = 0.7
                        
                    })
                }
                
            }){
                Image(systemName: "location")
            }
            
                
            }
            .frame(width: 35, height: 35)
            .scaledToFill()
            .background(backGroundColor)
            .cornerRadius(50)
         
            
            Spacer()
            ZStack{
            Button(action: {
                refreshed.toggle()
            }){
                Image(systemName: "arrow.clockwise")
                
            }
            
        }
            .frame(width: 35, height: 35)
            .scaledToFill()
            .background(backGroundColor)
            .cornerRadius(50)
            
    }
        .opacity(0.7)
        .font(Font.headline.weight(.light))
    }
    
    
    
}
