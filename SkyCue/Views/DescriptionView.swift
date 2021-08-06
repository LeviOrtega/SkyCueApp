//
//  DescriptionView.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI

struct DescriptionView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        Text(self.weatherVM.description == "" ? ""
                :"\(self.weatherVM.description.uppercased())")
            .font(Font.callout.weight(.light))
            .multilineTextAlignment(.center)
            .lineLimit(nil)
        
    }
    
}

