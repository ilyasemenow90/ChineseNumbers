//
//  Foundation+Utils.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    func next(from element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        
        return self[safe: index + 1]
    }

    func previous(from element: Element) -> Element? {
        guard let index = firstIndex(of: element) else { return nil }
        
        return self[safe: index - 1]
    }
}
