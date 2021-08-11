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
    
    
    var body: some View {
     
            Text(self.weatherVM.cityName)
                .lineLimit(1)
                .font(Font.largeTitle.weight(.light))
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
  
        
    }
}
