//
//  NetworkingComponents.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class NetworkingComponents: Components {
    func resolve(_: ReachabilityService.Protocol) -> ReachabilityService {
        singleton {
            ReachabilityDefault()
        }
    }
}
