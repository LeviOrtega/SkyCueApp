//
//  ForecastImageView.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/5/21.
//

import Foundation
import SwiftUI

struct ForecastImageView: View {
    
    var imageName: String
    
    
    var body: some View {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40, alignment: .center)
                .padding(5)
                
                
        }
    }
