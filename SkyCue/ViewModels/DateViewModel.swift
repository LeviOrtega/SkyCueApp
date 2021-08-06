//
//  DateViewModel.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI

func getTimeInfo(isNight: IsNight, weatherVM: WeatherViewModel){
    
    isNight.isNightTime = getNightTime(dateString: getTime(weatherVM: weatherVM), weatherVM: weatherVM)
    
    
}

func getDate(weatherVM: WeatherViewModel) -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, MMM d"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: weatherVM.timez)
    let localDate = dateFormatter.string(from: date)
    return localDate
}

func getDayOfWeek(weatherVM: WeatherViewModel) -> String{
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    dateFormatter.timeZone = TimeZone(secondsFromGMT: weatherVM.timez)
    let localDate = dateFormatter.string(from: date)
    return localDate
}

// convert time in unix UTC to short style date
func convertDate(timeResult: Double, weatherVM: WeatherViewModel) -> String{
    
    let date = Date(timeIntervalSince1970: timeResult)
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
    dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
    dateFormatter.timeZone = TimeZone(secondsFromGMT: weatherVM.timez)
    let localDate = dateFormatter.string(from: date)
    return localDate
}

func getTime(weatherVM: WeatherViewModel) -> String {
    
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.timeZone = TimeZone(secondsFromGMT: weatherVM.timez)
    let dateString = formatter.string(from: Date())
    return dateString
}


func getNightTime(dateString: String, weatherVM: WeatherViewModel) -> Bool {
    
    let date24 = convert12And24(dateString: dateString)
    
    // we get the sunset and sunrise raw numbers which are seconds unix UTC anc convert them to a date
    let sunriseRaw = convertDate(timeResult: weatherVM.sunrise, weatherVM: weatherVM)
    let sunsetRaw = convertDate(timeResult: weatherVM.sunset, weatherVM: weatherVM)
    
    // then we take that date and convert it into a 24 hour military time to use in the final comparison
    let sunrise = convert12And24(dateString: sunriseRaw)
    let sunset = convert12And24(dateString: sunsetRaw)
    
    //print(date24)
    
    return date24 <= sunrise || date24 >= sunset
}

func convert12And24(dateString: String) -> Date{
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
    
    guard let date24 = dateFormatter.date(from: dateString) else {
        dateFormatter.dateFormat = "HH:mm"
        let date12 = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = "h:mm a"
        return date12!
    }
    
    dateFormatter.dateFormat = "HH:mm"
    return date24
}
