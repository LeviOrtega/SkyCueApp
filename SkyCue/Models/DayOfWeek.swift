//
//  DayOfWeek.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/6/21.
//

import Foundation

class DayOfWeek{
    
    
    let dayStringDict = ["Mon" : 0,
                         "Tue": 1,
                         "Wed": 2,
                         "Thu": 3,
                         "Fri": 4,
                         "Sat": 5,
                         "Sun": 6
    ]
    
    let dayIntDict = [0: "Mon",
                      1: "Tue",
                      2: "Wed",
                      3: "Thu",
                      4: "Fri",
                      5: "Sat",
                      6: "Sun"
    ]
    
    
    func getDayByName(dayString: String) -> Int{
        if dayString == nil{
            return 0
        } else{
            return dayStringDict[dayString]!
        }
    }
    
    func getDayByNum(dayIndex: Int) -> String{
        if dayIndex == nil {
            return ""
        }
        else {
            return dayIntDict[dayIndex]!
        }
    }
}
