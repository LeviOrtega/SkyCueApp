//
//  WeeklyForecastView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI

struct WeeklyForecastView: View{
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    @ObservedObject var imageName: ImageName
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    var dayOfWeek = DayOfWeek()
    
    
    var body: some View{
        ZStack{
   
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(){
                        ForEach((0..<8)) { day in
                            let mainDesc = weatherVM.getDayMainDescription(dayIndex: day)
                            // we get the day of week as a string e.g, "Fri" then from the dict
                            // in dayOfWeek we get that days index
                            let currentDayOfWeekIndex
                                = dayOfWeek.getDayByName(dayString: getDayOfWeek(weatherVM: weatherVM))
                            
                            
                            VStack(alignment: .center, spacing: 5){
                                // add current day index e,g. 5 + day % num of days
                                Text(dayOfWeek.getDayByNum(dayIndex: (day + currentDayOfWeekIndex) % 7))
                                    .font(.system(size: 15, weight: .light, design: .default))
                                
                                
                                ForecastImageView(imageName: self.imageName.correlateName(uncorrelatedName: mainDesc, isNightTime: self.isNight.isNightTime))
                                    .font(.system(size: 25, weight: .ultraLight, design: .default))
                                
                                
                                
                                
                                
                                HStack(spacing: 5){
                                    
                                    Image(systemName: "thermometer")
                                    
                                    Text(weatherVM.getDayTemp(dayIndex: day) + " \u{00B0}F")
                                }
                                .font(.system(size: 15, weight: .light, design: .default))
                                
                                
                            }
                            
                        }
                        //.padding(5)
                        //.frame(width: 100, height: 90, alignment: .center)
                        .frame(minWidth: 0, idealWidth: 80, maxWidth:80 , minHeight: 90, idealHeight: 120, maxHeight: 120, alignment: .center)
                        
                        
                        
                        
                        
                    } //HStack
                    .padding()
                    .opacity(self.refreshViewOpacity)
                    .frame(minWidth: 0, idealWidth: (UIScreen.main.bounds.width > 720 ? UIScreen.main.bounds.width : 720), maxWidth: UIScreen.main.bounds.width)
                    
                    
                }// for each
            }.background(self.backGroundColor)
            .cornerRadius(50)
            
            
    
    }
}



