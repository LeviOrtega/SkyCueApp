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
    @ObservedObject var isNight: IsNight
    @Binding var backGroundColor: Color
    @Binding var refreshViewOpacity: Double
    var dayOfWeek = DayOfWeek()
    
    
    
    
    var body: some View {
        
        VStack{
            HourlyForecastView(weatherVM: self.weatherVM, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
            WeeklyForecastView(weatherVM: self.weatherVM, isNight: self.isNight, imageName: self.imageName, backGroundColor: self.$backGroundColor, refreshViewOpacity: self.$refreshViewOpacity)
        }
        
    }
}


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
               
                            ForecastImageView(imageName: hourImageName.correlateName(uncorrelatedName: mainDesc, isNightTime: isHourNight))
                                .font(Font.title.weight(.ultraLight))
                            
                            
                            
                            
                            HStack(spacing: 5){
                                
                                Image(systemName: "thermometer")
                                
                                Text(weatherVM.getHourlyTemp(hourIndex: hour) + " \u{00B0}F")
                               
                            }
                            
                        }
                        
                        
                    }.opacity(0.8)
                    .padding(5)
                    .frame(width: 80, height: 80, alignment: .center)
                    
                   
                    
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
                        
                        
                        VStack(alignment: .center, spacing: 10){
                            // add current day index e,g. 5 + day % num of days
                            Text(dayOfWeek.getDayByNum(dayIndex: (day + currentDayOfWeekIndex) % 7))
                            //.font(Font.callout.weight(.light))
                            
                            ForecastImageView(imageName: self.imageName.correlateName(uncorrelatedName: mainDesc, isNightTime: self.isNight.isNightTime))
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


