//
//  SearchView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI



struct SearchView: View {
    
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    
    var body : some View {
          
        self.backGroundColor
            .opacity(0.8)
            .ignoresSafeArea(.all)
        
            .overlay(
                

                TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, refreshViewOpacity: $refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime)
               
                
            )
            
                 
            
            .navigationBarBackButtonHidden(true)
            
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(Color.white)
            })
               
    }
        
    
}

//self.backGroundColor

//.opacity(0.8)
//.ignoresSafeArea(.all)
//.overlay(
  //  VStack{
    //TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, refreshViewOpacity: $refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime)
      //  Spacer()
    //}
      //  )
