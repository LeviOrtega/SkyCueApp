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
    @Binding var menuOpen: Bool

    
    var body: some View {
        
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Search", text: self.$weatherVM.cityName){
                    
                    endEditing()
                    
                    self.menuOpen.toggle()
                    withAnimation(.easeInOut(duration: refreshTime), {
                        self.refreshViewOpacity = 0
                        
                    })
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 0.2) {
                        
                        self.weatherVM.search()
                    }
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 1) {
                        
                        // after the initial animation we want to animate back in
                        withAnimation(.easeInOut(duration: refreshTime), {
                            self.refreshViewOpacity = 1
                            
                        })
                    }
                 
                    
                }// textField
                
                    .foregroundColor(.primary)

                
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            .font(Font.title.weight(.light))
        }
        //.padding(.horizontal)


       
        
        
        
        
    }
    
}


