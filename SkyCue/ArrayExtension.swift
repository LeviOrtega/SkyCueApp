//
//  ArrayExtension.swift
//  SkyCue
//
//  Created by Levi Ortega on 8/11/21.
//

import Foundation


extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
