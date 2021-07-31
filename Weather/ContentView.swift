//
//  ContentView.swift
//  Weather
//
//  Created by Levi Ortega on 7/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    
    init() {
        self.weatherVM = WeatherViewModel()
    }
    
    var body: some View {
        VStack(alignment: .center){
            
            
            TextField("Enter City Name", text: self.$weatherVM.cityName){
                self.weatherVM.search()
            }.padding()
            .font(.custom("Arial", size: 50))
            .fixedSize()
            .foregroundColor(.black)
            
            Text("Temperature \(self.weatherVM.temperature) Fahrenheit")
            Text("Humidity \(self.weatherVM.humidity)")
            Text("Details \(self.weatherVM.desc)")
                
            
            
            
        }.frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
