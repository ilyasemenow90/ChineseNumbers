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
    func didSelectItem()
}

protocol ExploreDetailsEventsHandler {
    
}

protocol ExploreMasterUserInterface: AnyObject {
    func update(with: [Number])
}

protocol ExploreDetailsUserInterface: AnyObject {
    
}
