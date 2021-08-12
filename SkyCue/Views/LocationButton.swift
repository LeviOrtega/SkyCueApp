//
//  LocationButton.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/11/21.
//

import Foundation
import SwiftUI


struct LocationButton: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @Binding var menuOpen: Bool
    @Binding var refreshTime: Double
    @Binding var refreshViewOpacity: Double
    var locationName: String = ""
    
    var body: some View{
        HStack{
            
        Button(action:{
            
            self.menuOpen.toggle()
            endEditing()
            
            withAnimation(.easeInOut(duration: refreshTime), {
                self.refreshViewOpacity = 0
                
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 0.2) {
                
                self.weatherVM.cityName = locationName
                self.weatherVM.search()
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + refreshTime + 1) {
                
                // after the initial animation we want to animate back in
                withAnimation(.easeInOut(duration: refreshTime), {
                    self.refreshViewOpacity = 1
                    
                })
            }
            
        }){
            Text(locationName)
                .font(Font.headline.weight(.light))
        }
          
            
        }
        
    }
    
}

