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
    @State private var keyboardHeight: CGFloat = 0
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double

    
    var body: some View {
        TextField("Location", text: self.$weatherVM.cityName){
            
            print("Searching location: \(weatherVM.cityName)")
            refreshed.toggle()
            
            
        }.padding()
        .font(Font.largeTitle.weight(.light))
        .multilineTextAlignment(.center)
        .opacity(refreshViewOpacity)
        //.textFieldStyle(RoundedBorderTextFieldStyle())
        .background(self.backGroundColor)
        .cornerRadius(100)
        
        
        
        
    }
    
}
