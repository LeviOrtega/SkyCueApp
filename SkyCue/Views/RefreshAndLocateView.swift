//
//  RefreshAndLocateView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI


struct RefreshAndLocateView: View {
    
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var error: Error
    @Binding var refreshed: Bool
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    
    var body: some View {
        HStack{
            
            ZStack{
                Button(action: {
                    
                    locate(locationManager: locationManager, weatherVM: weatherVM, error: error, onUserDemand: true)
                    refreshed.toggle()
                    
                }){
                    Image(systemName: "location")
                }
                
                
            }
            .frame(width: 35, height: 35)
          
            Spacer()
            ZStack{
                Button(action: {
                    refreshed.toggle()
                }){
                    Image(systemName: "arrow.clockwise")
                    
                }
                
            }
            .frame(width: 35, height: 35)
            
        }
        
        .font(Font.headline.weight(.light))
    }
    
    
    

}
