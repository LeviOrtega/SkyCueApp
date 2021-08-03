//
//  InfoView.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI

struct InfoView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
    
        HStack{
  
            HStack{
                Image(systemName: "globe")
                Text(self.weatherVM.country == "" ? ""
                        :"\(self.weatherVM.country)")
                
            }
            
            HStack{
                Image(systemName: "thermometer")
                Text(self.weatherVM.temperature == "" ? ""
                        :"\(self.weatherVM.temperature) \u{00B0}F")
                
            }
       
            
            HStack{
                Image(systemName: "drop")
                Text(self.weatherVM.humidity == "" ? ""
                        : "\(self.weatherVM.humidity)%")
                
            }
      
        }.opacity(0.7)
        .font(Font.title.weight(.light))
        
        
    }
}
