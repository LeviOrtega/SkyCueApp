//
//  LocationName.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/11/21.
//

import Foundation


struct LocationName: Identifiable, Hashable {
    
    let name: String
    var id: String { name }
}
