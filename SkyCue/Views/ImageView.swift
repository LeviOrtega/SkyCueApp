//
//  ImageView.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

import Foundation
import SwiftUI

struct ImageView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    var imageName: String
    
    
    var body: some View {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(minWidth: 40, idealWidth: 90, maxWidth: 140, minHeight: 50, idealHeight: 100, maxHeight: 150, alignment: .center)
                //.frame(width: 100, height: 100, alignment: .center)
                .font(Font.title.weight(.ultraLight))
                .padding(5)
        }
    }
    
    

