//
//  ReachabilityService.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

protocol ReachabilityServiceDelegate: AnyObject {
    func connectionReachable()
    func connectionUnreachable()
}

protocol ReachabilityService {
    var isReachableNow: Bool { get }
    
    func subscribe(_: ReachabilityServiceDelegate)
    func unsubscribe(_: ReachabilityServiceDelegate)
}
