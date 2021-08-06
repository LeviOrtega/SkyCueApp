//
//  Location.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/6/21.
//

import Foundation


struct Location: Identifiable, Codable{
    let name: String
    
    var id: String { name }
}
