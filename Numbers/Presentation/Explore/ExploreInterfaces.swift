//
//  ExploreInterfaces.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

protocol ExploreWireframeProtocol {
    func showDetails()
}

protocol ExploreMasterEventsHandler {
    func didLoadView()
    func didSelect(number: NumberModel)
}

protocol ExploreDetailsEventsHandler {
    func selectNextNumber()
    func selectPreviousNumber()
}

protocol ExploreMasterUserInterface: AnyObject {
    func update(with: [NumberModel])
    func updateSelected(number: NumberModel)
    func showUpdateDataFailed()
}

protocol ExploreDetailsUserInterface: AnyObject {
    func update(with: NumberModel)
    func updatePages(count: Int)
}

struct NumberModel: Equatable {
    let number: Number
    let position: Int
}
