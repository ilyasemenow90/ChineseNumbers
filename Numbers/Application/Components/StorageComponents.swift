//
//  StorageComponents.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class StorageComponents: Components {
    func resolve(_: ContentStorage.Protocol) -> ContentStorage {
        ContentInMemoryStorage()
    }
    
    func resolve(_: NubmersParser.Protocol) -> NubmersParser {
        ContentJSONParser()
    }
}
