//
//  SearchView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI



struct SlideMenu: View {
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    @Binding var menuOpen: Bool
    
    @Binding var locationNameList: [LocationName]
    
    
    let width: CGFloat
    let height: CGFloat
    
    
    private func deleteRow(at indexSet: IndexSet) {
            self.locationNameList.remove(atOffsets: indexSet)
        }
    
    var body: some View {
        ZStack{
            GeometryReader { _ in
                EmptyView()
            }
            
            .background(backGroundColor.opacity(0.5))
            .opacity(self.menuOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuOpen.toggle()
            }
            
            VStack{
                
                
                TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, refreshViewOpacity: $refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime, menuOpen: self.$menuOpen)
                
                VStack{
                    
                    Text("Saved Locations")
                        .padding(.top, 10)
                        .font(Font.headline.weight(.light))
                    
                    List{
                        
                        ForEach(locationNameList) { locName in
                        
                        LocationButton(weatherVM: self.weatherVM, menuOpen: self.$menuOpen, refreshTime: self.$refreshTime, refreshViewOpacity: self.$refreshViewOpacity, locationName: locName.name)
                        
                        }
                        .onDelete(perform: self.deleteRow)
                    }
                    
                    
                    
                }// VStack
                .frame(width: self.width*0.95)
                //.padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                .foregroundColor(.primary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
            }
            .offset(y: self.menuOpen ?  self.height/2: self.height*2)
            .animation(.default)
            
            
            
            
        }
        .opacity(refreshViewOpacity)
        .ignoresSafeArea(.all)
        
    }
}
