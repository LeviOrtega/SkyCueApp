//
//  UserInput.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI


struct TextBoxView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @State private var keyboardHeight: CGFloat = 0
    @Binding var backGroundColor: Color
    @Binding var refreshed: Bool
    @Binding var textFieldViewOpacty: Double


    var refreshTime: Double = 0.3

    
    var body: some View {
        TextField("Location", text: self.$weatherVM.cityName){
            
            print("Searching location: \(weatherVM.cityName)")
            refreshed.toggle()
            
            
        }.padding()
        .font(Font.largeTitle.weight(.light))
        .multilineTextAlignment(.center)
        .opacity(textFieldViewOpacty)
        //.textFieldStyle(RoundedBorderTextFieldStyle())
        
        .background(self.backGroundColor)
        .cornerRadius(100)
        
        
        
    }
    
}
