//
//  LocationView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/6/21.
//

import Foundation
import SwiftUI


struct LocationView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    var location: Location
    
    
    var body: some View {
        VStack{
            Text(location.name)
            
        }
        .onAppear(){
            weatherVM.cityName = location.name
            weatherVM.search()
        }
        
    }

    
    
    
    
}

