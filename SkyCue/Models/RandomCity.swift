//
//  RandomCity.swift
//  Weather
//
//  Created by Levi Ortega on 8/2/21.
//

import Foundation
import SwiftUI

func randomCity() -> String {
    
    let cityArr = ["Tokyo",
                   "Delhi",
                   "Shanghai",
                   "Sao Paulo",
                   "Mexico City",
                   "Dhaka",
                   "Cairo",
                   "Beijing",
                   "Mumbai",
                   "Osaka",
                   "Karachi",
                   "Chongqing",
                   "Istanbul",
                   "Buenos Aires",
                   "Kolkata",
                   "Kinshasa",
                   "Lagos",
                   "Manila",
                   "Tianjin",
                   "Guangzhou",
                   "Rio de Janeiro",
                   "Lahore",
                   "Bangalore",
                   "Moscow",
                   "Shenzhen",
                   "Chennai",
                   "Bogota",
                   "Paris",
                   "Jakarta",
                   "Lima",
                   "Bangkok",
                   "Hyderabad",
                   "Seoul",
                   "Nagoya",
                   "London",
                   "Chengdu",
                   "Tehran",
                   "Nanjing",
                   "Ho Chi Minh City",
                   "Luanda",
                   "Wuhan",
                   "Ahmedabad",
                   "New York City",
                   "Kuala Lumpur",
                   "Hangzhou",
                   "Hong Kong",
                   "Surat",
                   "Dongguan",
                   "Suzhou",
                   "Foshan",
                   "Riyadh",
                   "Shenyang",
                   "Baghdad",
                   "Dar es Salaam",
                   "Santiago",
                   "Pune",
                   "Madrid",
                   "Tel Aviv"
    ]
    
    
    return cityArr[Int.random(in: 0..<cityArr.count)]
    
    
}
