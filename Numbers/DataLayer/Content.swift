//
//  Content.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

protocol ContentDelegate: AnyObject {
    func contentDidUpdate()
}

protocol Content {
    func updateData()
    func allData() -> [Number]
    
    func subscribe(_: ContentDelegate)
    func unsubscribe(_: ContentDelegate)
}

protocol ContentUpdater {
    var isUpdateActive: Bool { get }
    
    func updateData(_: @escaping (Result<[Number], Error>) -> ())
}

protocol NubmersParser {
    func parseNumbers(from: Data) -> [Number]
}

protocol ContentStorage {
    func store(data: [Number])
    func getAllData() -> [Number]
}
