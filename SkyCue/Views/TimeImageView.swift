//
//  DaytimeView.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI


struct TimeImageView: View {
    
    
    var body: some View {
        // center images together
        VStack(alignment: .center, spacing: 5){
            Image(systemName: "globe")
            Image(systemName: "calendar")
            Image(systemName: "clock")
            Image(systemName: "sunrise")
            Image(systemName: "sunset")
            
        }
    }
}
