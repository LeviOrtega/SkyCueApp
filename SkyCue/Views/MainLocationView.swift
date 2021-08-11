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
    @Binding var locationNameList: [LocationName]
    
    var body: some View {
        ZStack{
            
            
            
            Button(action: {
                if !self.menuOpen {
                    
                    self.menuOpen.toggle()
                }
                
            }){
                SearchedLocationView(weatherVM: self.weatherVM).opacity(refreshViewOpacity)
                
                
            }
            
            
            
            
            HStack{
                Spacer()
                Button(action: {
                    
                    
                    self.locationNameList.append(LocationName(name: weatherVM.cityName))
                    // only add unique items to the location list
                    self.locationNameList = self.locationNameList.unique()
                    
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



//
//Button(action: {
//    if !self.menuOpen {
//
//        self.menuOpen.toggle()
//    }
//
//}){
//
//    ZStack{
//        Image(systemName: "magnifyingglass")
//
//    }.frame(width: 35, height: 35)
//    .scaledToFill()
//}
//.padding(5)
