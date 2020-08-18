//
//  ContentInMemoryStorage.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class ContentInMemoryStorage {
    private var data: [Number] = []
}

extension ContentInMemoryStorage: ContentStorage {
    func store(data: [Number]) {
        self.data = data
    }
    
    func getAllData() -> [Number] {
        data
    }
}
