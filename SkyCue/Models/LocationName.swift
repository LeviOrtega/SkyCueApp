//
//  LocationName.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/11/21.
//

import Foundation


struct LocationName: Identifiable, Codable{
    
    let name: String?
    var id: String { (name?.filter ({ !" \n\t\r".contains($0) }).uppercased())!}
}
