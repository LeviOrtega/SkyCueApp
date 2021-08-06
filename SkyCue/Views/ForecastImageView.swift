//
//  ForecastImageView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/5/21.
//

import Foundation
import SwiftUI

struct ForecastImageView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    var imageName: String
    
    
    var body: some View {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                //.frame(width: 100, height: 100, alignment: .center)
                .opacity(0.8)
                .font(Font.title.weight(.ultraLight))
        }
    }
