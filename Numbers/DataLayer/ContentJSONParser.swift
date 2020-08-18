//
//  ContentJSONParser.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class ContentJSONParser {
    private let jsonDecoder = JSONDecoder()
}

extension ContentJSONParser: NubmersParser {
    func parseNumbers(from data: Data) -> [Number] {
        let numbers = try? jsonDecoder.decode([Number].self, from: data)
        
        return numbers ?? []
    }
}
