//
//  MainStackView.swift
//  Weather
//
//  Created by Levi Ortega on 8/3/21.
//

import Foundation
import SwiftUI



struct MainStackBackground: View {
    
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
    
    var body: some View{
        
        
            self.backGroundColor
                
                .opacity(0.8)
                .ignoresSafeArea(.all)
                .overlay(
                    MainContentView(weatherVM: self.weatherVM, isNight: self.isNight, locationManager: self.locationManager, imageName: self.imageName, error: self.error, refreshViewOpacity: self.$refreshViewOpacity, refreshed: self.$refreshed, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime, menuOpen: self.$menuOpen)
                       
                
                )
                
                .foregroundColor(.white)
                
            
     
        
        
    }
    
    
    
}

