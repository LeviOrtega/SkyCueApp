//
//  CurrentTimeView.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI

struct TimeView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            
            Text(self.weatherVM.country == "" ? ""
                    :"\(self.weatherVM.country)")
            
            Text(getDate(weatherVM: self.weatherVM))
                
            Text(getTime(UTC: weatherVM.timez))
                
                Text(self.weatherVM.sunrise == 0.0 ? "" : "\(convertDate(timeResult: self.weatherVM.sunrise, weatherVM: weatherVM))")
    
                Text(self.weatherVM.sunset == 0.0 ? "" : "\(convertDate(timeResult: self.weatherVM.sunset, weatherVM: weatherVM))")
        
            
        }
    }
}
