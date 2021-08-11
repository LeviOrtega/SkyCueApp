//
//  SearchedLocationView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI


struct SearchedLocationView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double

    
    var body: some View {
        Text(self.weatherVM.cityName)
            
            .padding()
            .font(Font.largeTitle.weight(.light))
            .opacity(refreshViewOpacity)
            .background(self.backGroundColor)
            .cornerRadius(100)
            
        
        
        
        
    }
}
