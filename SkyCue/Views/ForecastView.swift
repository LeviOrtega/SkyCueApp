//
//  ForecastView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/6/21.
//

import Foundation
import SwiftUI


struct ForecastView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var imageName: ImageName
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    var dayOfWeek = DayOfWeek()
    
    
    
    
    var body: some View {
        ZStack{
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 30){
                ForEach((1..<8)) { day in
                    var mainDesc = weatherVM.getDayMainDescription(dayIndex: day)
                    // we get the day of week as a string e.g, "Fri" then from the dict
                    // in dayOfWeek we get that days index
                    var currentDayOfWeekIndex
                        = dayOfWeek.getDayByName(dayString: getDayOfWeek(weatherVM: weatherVM))
                    
                    VStack(alignment: .center){
                        
                        
                        // add current day index e,g. 5 + day % num of days
                        Text(dayOfWeek.getDayByNum(dayIndex: (day + currentDayOfWeekIndex) % 7))
                            .font(Font.callout.weight(.light))
                        
                        ForecastImageView(weatherVM: weatherVM, imageName: self.imageName.correlateName(uncorrelatedName: mainDesc))
                        
                     
                        Text(self.weatherVM.getDayDescription(dayIndex: day).uppercased())
                            .font(Font.callout.weight(.light))
                            .allowsTightening(true)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                        
                    
                        HStack{
                            Image(systemName: "thermometer")
                            Text(weatherVM.getDayTemp(dayIndex: day) + " \u{00B0}F")
                                .font(Font.callout.weight(.light))
                        }
                        
                        HStack{
                            Image(systemName: "drop")
                            Text(weatherVM.getDayHumidity(dayIndex: day) + "%")
                                .font(Font.callout.weight(.light))
                        }
                    }
                    .padding(10)
              
                    
                    
                }
            }.opacity(0.8)
            
            
        }.padding()
        .opacity(self.refreshViewOpacity)
            
            
        }.background(self.backGroundColor)
        .cornerRadius(50)
        
    }
}
