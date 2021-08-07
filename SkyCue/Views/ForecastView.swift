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
        
        VStack{
            HourlyForecastView(weatherVM: self.weatherVM, imageName: self.imageName, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
            WeeklyForecastView(weatherVM: self.weatherVM, imageName: self.imageName, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
        }
        
    }
}


struct HourlyForecastView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var imageName: ImageName
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    
    var body: some View{
        ZStack{
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(){
                    ForEach((0..<24)) { hour in
                        var mainDesc = weatherVM.getHourlyMainDescription(hourIndex: hour)
                        
                        VStack(alignment: .center, spacing: 5){
           
                            Text(getTime(UTC: self.weatherVM.getHourlyTime(hourIndex: hour)))
                          
                            
                            ForecastImageView(weatherVM: weatherVM, imageName: self.imageName.correlateName(uncorrelatedName: mainDesc))
                                .font(Font.title.weight(.ultraLight))
                            
                            
                            
                            
                            HStack(spacing: 5){
                                
                                Image(systemName: "thermometer")
                                
                                Text(weatherVM.getHourlyTemp(hourIndex: hour) + " \u{00B0}F")
                               
                            }
                            
                        }
                        
                    }.opacity(0.8)
                    .padding(5)
                    .frame(width: 70, height: 100, alignment: .center)
                    
                }.padding()
                .opacity(self.refreshViewOpacity)
                .font(.system(size: 15, weight: .light, design: .default))
                
            }
        }.background(self.backGroundColor)
        .cornerRadius(50)
        
        
    }
}

struct WeeklyForecastView: View{
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var imageName: ImageName
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    var dayOfWeek = DayOfWeek()
    
    
    var body: some View{
        ZStack{
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(){
                    ForEach((0..<8)) { day in
                        var mainDesc = weatherVM.getDayMainDescription(dayIndex: day)
                        // we get the day of week as a string e.g, "Fri" then from the dict
                        // in dayOfWeek we get that days index
                        var currentDayOfWeekIndex
                            = dayOfWeek.getDayByName(dayString: getDayOfWeek(weatherVM: weatherVM))
                        
                        
                        VStack(alignment: .center, spacing: 5){
                            // add current day index e,g. 5 + day % num of days
                            Text(dayOfWeek.getDayByNum(dayIndex: (day + currentDayOfWeekIndex) % 7))
                            //.font(Font.callout.weight(.light))
                            
                            ForecastImageView(weatherVM: weatherVM, imageName: self.imageName.correlateName(uncorrelatedName: mainDesc))
                                .font(Font.title.weight(.ultraLight))
                            
                            
                            
                            
                            HStack(spacing: 5){
                                
                                Image(systemName: "thermometer")
                                
                                Text(weatherVM.getDayTemp(dayIndex: day) + " \u{00B0}F")
                                //.font(Font.callout.weight(.light))
                            }
                            
                        }
                        
                    }.opacity(0.8)
                    .padding(5)
                    .frame(width: 70, height: 100, alignment: .center)
                    
                }.padding()
                .opacity(self.refreshViewOpacity)
                .font(.system(size: 15, weight: .light, design: .default))
                
            }
        }.background(self.backGroundColor)
        .cornerRadius(50)
        
        
    }
}


