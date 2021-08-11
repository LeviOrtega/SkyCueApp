//
//  ForecastView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/6/21.
//

import Foundation
import SwiftUI


struct ForecastView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var imageName: ImageName
    @ObservedObject var isNight: IsNight
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    
    
    var body: some View {
        
        VStack{
            HourlyForecastView(weatherVM: self.weatherVM, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
            WeeklyForecastView(weatherVM: self.weatherVM, isNight: self.isNight, imageName: self.imageName, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
        }
        
    }
}




