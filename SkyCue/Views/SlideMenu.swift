//
//  SearchView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI



struct SlideMenu: View {
    
    
    @ObservedObject var weatherVM: WeatherViewModel
    @ObservedObject var isNight: IsNight
    
    @Binding var refreshed: Bool
    @Binding var refreshViewOpacity: Double
    @Binding var backGroundColor: Color
    @Binding var refreshTime: Double
    @Binding var menuOpen: Bool

    
    
    let width: CGFloat
    let height: CGFloat
    
    
    
    
    private func deleteRow(at indexSet: IndexSet) {
        self.weatherVM.locationNameList.remove(atOffsets: indexSet)
        }
    
    var body: some View {
        ZStack{
            GeometryReader { _ in
                EmptyView()
            }
            
            .background(backGroundColor.opacity(0.6))
            .opacity(self.menuOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuOpen.toggle()
                endEditing()
               
            }
            
            VStack{
                
                
                TextBoxView(weatherVM: self.weatherVM, isNight: self.isNight, refreshed: $refreshed, refreshViewOpacity: $refreshViewOpacity, backGroundColor: self.$backGroundColor, refreshTime: self.$refreshTime, menuOpen: self.$menuOpen)
                    
                
                VStack{
                    
                    Text("Saved Locations")
                        .padding(.top, 15)
                        .font(Font.headline.weight(.light))
                    
                    
                    List{
                        
                        ForEach(weatherVM.locationNameList) { locName in
                            
                          
                            LocationButton(weatherVM: self.weatherVM, menuOpen: self.$menuOpen, refreshTime: self.$refreshTime, refreshViewOpacity: self.$refreshViewOpacity, locationName: locName.name!)
                                
                                
                               
                                .listRowBackground(
                                    Color(.secondarySystemBackground)
                                        
                                       )
                          
                        
                        }
                    
                        
                        
                        
                        .onDelete(perform: self.deleteRow)
                    }
                    
                   
                 
                    //.cornerRadius(20)
                    .onAppear(){
                        
                          UITableViewCell.appearance().backgroundColor = .secondarySystemBackground
                        UITableView.appearance().backgroundColor = .secondarySystemBackground
                    }
                    .padding(5)
                    
                    
                    
                }// VStack
                .frame(height: self.height)
                //.foregroundColor(.primary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
            }
            
        
          
            .frame(width: self.width*0.95)
            .offset(y: self.menuOpen ?  UIScreen.main.bounds.height - self.height*2: self.height*2)
            .animation(.default)
            
            
            
            
        }
        .opacity(refreshViewOpacity)
        .ignoresSafeArea(.all)
        
    }
    
    
   
    
}

func endEditing() {
       UIApplication.shared.endEditing()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


