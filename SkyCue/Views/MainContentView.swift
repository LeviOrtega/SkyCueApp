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
    
    
    var body: some View {
        
        VStack(alignment: .center){
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
                    //.frame(width: UIScreen.main.bounds.width)
                    .scaledToFill()
                    
                    
                    
                    Spacer()
                    
                    HStack{
                        TimeImageView()
                        TimeView(weatherVM: self.weatherVM)
                    }
                    
                    .font(Font.headline.weight(.light))
                    .scaledToFill()
                    
                    
                    Spacer()
                    
                    
                }
                .opacity(refreshViewOpacity)
                .padding(20)
                
            }
            .background(backGroundColor)
            .cornerRadius(50)
            
        
                
            TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, refreshViewOpacity: $refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime)
                
                
                
            
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



