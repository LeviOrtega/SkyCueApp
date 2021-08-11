//
//  UserInput.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI
import Combine


struct TextBoxView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double

    
    var body: some View {
        
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Search", text: self.$weatherVM.cityName){
                    self.refreshed.toggle()
                }
                    .foregroundColor(.primary)

                
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
        //.background(self.backGroundColor)


       
        
        
        
        
    }
    
}
