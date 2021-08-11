//
//  MainLocationView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/11/21.
//

import Foundation
import SwiftUI

struct MainLocationView: View {
    
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @Binding var refreshViewOpacity: Double
    @Binding var refreshed: Bool
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    @Binding var menuOpen: Bool

    
    var body: some View {
        ZStack{
            
            
            
            Button(action: {
                if !self.menuOpen {
                    
                    self.menuOpen.toggle()
                }
                
            }){
                SearchedLocationView(weatherVM: self.weatherVM).opacity(refreshViewOpacity)
                
                
            }
            .onLongPressGesture {
                self.weatherVM.cityName = randomCity()
                weatherVM.search()
            }
            
            
           
            
            
            
            
            HStack{
                
                
                Spacer()
                Button(action: {
                    
                    
                    let location = LocationName(name: weatherVM.cityName)
                    
                    if canAddToList(locationNameList: self.weatherVM.locationNameList, location: location){
                        self.weatherVM.locationNameList.append(location)
                    }
                    
                    // open location list
                    self.menuOpen.toggle()
                    
                    
                }){
                    
                    
                    Image(systemName: "plus")
                        
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                        
                        
                }.padding(5)
                .font(Font.subheadline.weight(.light))
                .opacity(refreshViewOpacity)
                
                
            }
            
            
            
        }
        .padding()
        .background(self.backGroundColor)
        .cornerRadius(100)
    }
}




func canAddToList(locationNameList: [LocationName], location: LocationName) -> Bool{
    
    let location = location
    
    for loc in locationNameList {
        if loc.id == location.id {
            return false
        }
    }
    return true
}
