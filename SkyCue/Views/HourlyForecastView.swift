//
//  HourlyForecastView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI


struct HourlyForecastView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    
    var body: some View{
        ZStack{
          
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack{
                    ForEach(0..<25) { hour in
                       
                        
                        let hourImageName = ImageName()
                        let mainDesc = weatherVM.getHourlyMainDescription(hourIndex: hour)
                        let hourDt = self.weatherVM.getHourlyTime(hourIndex: hour)
                        let hourString = convertDate(timeResult: hourDt, weatherVM: self.weatherVM)
                        let isHourNight = getNightTime(dateString: hourString, weatherVM: weatherVM)
                      
                        
                        
                        
                        VStack(alignment: .center, spacing: 2){
                            Text(hourString)
                                .font(.system(size: 15, weight: .light, design: .default))

               
                            ForecastImageView(imageName: hourImageName.correlateName(uncorrelatedName: mainDesc, isNightTime: isHourNight))
                                .font(.system(size: 25, weight: .thin, design: .default))


                            
                            
                            
                            
                            HStack(spacing: 5){
                                
                                Image(systemName: "thermometer")
                                
                                Text(weatherVM.getHourlyTemp(hourIndex: hour) + " \u{00B0}F")
                               
                            }
                            .font(.system(size: 15, weight: .light, design: .default))

                            
                        }
                        
                        
                    }
                    //.padding(5)
                    .frame(minWidth: 0, idealWidth: 80, maxWidth:80 , minHeight: 90, idealHeight: 120, maxHeight: 120, alignment: .center)
                    
                    
                    
                   
                    
                }.padding()
                .opacity(self.refreshViewOpacity)
                
                
                
            }
        }.background(self.backGroundColor)
        .cornerRadius(50)
        
        
    }
    
   
}

