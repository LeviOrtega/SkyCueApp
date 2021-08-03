//
//  ErrorAlert.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

import Foundation
import SwiftUI


struct ErrorAlert: View {
    
    @Binding var displayError: Bool
    @Binding var errorMessage: String
    @Binding var errorType: String
    
    var body: some View{
        Text("")
            .alert(isPresented: self.$displayError, content: {
                
                Alert(title: Text(errorType), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                
            })
        
        
    }
}
