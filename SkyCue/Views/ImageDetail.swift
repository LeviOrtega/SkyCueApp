//
//  ImageDetail.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/10/21.
//

import Foundation
import SwiftUI

struct ImageDetail: View {
    var imageName: String = ""
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .frame(width: 15, height: 15, alignment: .center)
            .scaledToFit()
    }
}
