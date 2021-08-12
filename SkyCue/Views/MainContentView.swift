//
//  MainContentView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI


struct MainContentView: View {
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var imageName: ImageName
    @ObservedObject var error: Error
    @Binding var refreshViewOpacity: Double
    @Binding var refreshed: Bool
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    @Binding var menuOpen: Bool
    
    
    var body: some View {
        
        
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
        
        VStack(alignment: .center){
            VStack{
                ZStack{
                    
                    HStack{
                        
                        Spacer()
                        
                        VStack(alignment: .center, spacing: 0){
                            
                            ImageView(weatherVM: self.weatherVM, imageName: imageName.correlateName(uncorrelatedName: self.weatherVM.main, isNightTime: self.isNight.isNightTime))
                            Text(self.weatherVM.temperature == "" ? ""
                                    :"\(self.weatherVM.temperature) \u{00B0}F")
                                .font(Font.largeTitle.weight(.light))
                            DescriptionView(weatherVM: self.weatherVM)
                            
                        }
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .frame(width: 150, height: 200, alignment: .center)
                        .scaledToFill()
                        
                        
                        
                        Spacer()
                        
                        LocationDetailView(weatherVM: self.weatherVM)
                            
                            .font(Font.headline.weight(.light))
                            .scaledToFill()
                        
                        
                        Spacer()
                        
                        
                    }// HStack
                    .opacity(refreshViewOpacity)
                    .padding(20)
                    
                }//ZStack
                .background(backGroundColor)
                .cornerRadius(50)
                
                
                MainLocationView(weatherVM: self.weatherVM, refreshViewOpacity: self.$refreshViewOpacity, refreshed: self.$refreshed, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime, menuOpen: self.$menuOpen)
            }.gesture(detectDirectionalDrags)
            
            
            ForecastView(weatherVM: self.weatherVM, imageName: self.imageName, isNight: self.isNight, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
            
            
            RefreshAndLocateView(locationManager: locationManager, weatherVM: weatherVM, isNight: isNight, error: error, refreshed: $refreshed, backGroundColor: $backGroundColor, refreshTime: $refreshTime)
            
        }
        // total vstack padding
        .padding(.init(top: 20, leading: 5, bottom: 15, trailing: 5))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .scaledToFill()
        .opacity(0.6)
        
        
        
        
        
        
    }
    
}



