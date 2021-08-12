//
//  LocationDetailView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI


struct LocationDetailView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
          
            HStack{
                ImageDetail(imageName: "globe")
                Text(self.weatherVM.country == "" ? ""
                        :"\(self.weatherVM.country)")
            }
            HStack{
                ImageDetail(imageName: "clock")
                Text(self.weatherVM.timez == 0 ? "" : "\(getTime(UTC: weatherVM.timez))")
            }
            HStack{
                ImageDetail(imageName: "calendar")
                Text(self.weatherVM.timez == 0 ? "" :  getDate(weatherVM: self.weatherVM))
            }
           
            
            HStack{
                Image(systemName: "sunrise.fill")
                    .resizable()
                    .frame(width: 20, height: 17, alignment: .center)
                    
                    .scaledToFill()
                Text(self.weatherVM.sunrise == 0.0 ? "" : "\(convertDate(timeResult: self.weatherVM.sunrise, weatherVM: weatherVM))")
            }
            HStack{
                Image(systemName: "sunset")
                    .resizable()
                    .frame(width: 20, height: 17, alignment: .center)
                    
                    .scaledToFit()
                Text(self.weatherVM.sunset == 0.0 ? "" : "\(convertDate(timeResult: self.weatherVM.sunset, weatherVM: weatherVM))")
                
            }
            
//            HStack{
//                ImageDetail(imageName: "sun.min.fill")
//                Text(self.weatherVM.uvi)
//                
//            }
            
            
            
        }
        
        
        
        
        
    }
}
