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
    
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 20){
                ForEach((1..<7)) { day in
                    var mainDesc = weatherVM.getDayMainDescription(dayIndex: day)
                    
                    
                    VStack(alignment: .center){
                        ForecastImageView(weatherVM: weatherVM, imageName: self.imageName.correlateName(uncorrelatedName: mainDesc))
                     
                        Text(self.weatherVM.getDayDescription(dayIndex: day).uppercased())
                    
                        HStack{
                            Image(systemName: "thermometer")
                            Text(weatherVM.getDayTemp(dayIndex: day) + " \u{00B0}F")
                        }
                    }
                    
                }
            }
            
        }.padding()
        .cornerRadius(50)
    }
}
