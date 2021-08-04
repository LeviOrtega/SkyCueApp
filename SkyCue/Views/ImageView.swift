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
                .frame(width: 100, height: 100, alignment: .center)
                .opacity(0.8)
                .font(Font.title.weight(.ultraLight))
        }
    }
    
    

