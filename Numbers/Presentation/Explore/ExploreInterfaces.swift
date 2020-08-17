//
//  ExploreInterfaces.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

protocol ExploreUserInterface {
    func update()
}

protocol ExploreEventsHandler {
    func didLoadView()
}

protocol ExploreWireframe {
    func showDetails()
}
