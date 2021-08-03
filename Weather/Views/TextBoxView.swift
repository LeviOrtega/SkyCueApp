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
    @State private var backGroundColor = Color.blue
    
    var body: some View {
        TextField("Location", text: self.$weatherVM.cityName){
            self.weatherVM.search()
            
        }.padding()
        .font(Font.largeTitle.weight(.light))
        .multilineTextAlignment(.center)
        .opacity(0.7)
        //.textFieldStyle(RoundedBorderTextFieldStyle())
        .onChange(of: isNight.isNightTime){ change in
            if isNight.isNightTime {
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.backGroundColor = Color.black
                                }
            }
            else {
                withAnimation(.easeInOut(duration: 1)) {
                    self.backGroundColor = Color.blue
                                }
            }
        }
        
        .background(self.backGroundColor)
        .cornerRadius(100)
        
        
        
    }
    
}
