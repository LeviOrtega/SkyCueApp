//
//  Error.swift
//  Weather
//
//  Created by Levi Ortega on 8/1/21.
//

import Foundation


class Error: ObservableObject {
    @Published var displayError: Bool = false
    @Published var errorMessage: String = ""
    @Published var errorType: String = ""
    
    
}
