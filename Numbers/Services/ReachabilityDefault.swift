//
//  ReachabilityDefault.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

final class ReachabilityDefault {
    private struct Options {
        static let hostName = "dev.taptic.com"
    }
    
    private let reachability: Reachability
    private let subscribers: Notifier<ReachabilityServiceDelegate>
    
    init() {
        reachability = Reachability.init(hostName: Options.hostName)
        subscribers = Notifier()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityStatusChaged),
            name: .reachabilityChanged,
            object: nil
        )
        
        reachability.startNotifier()
    }
}

extension ReachabilityDefault: ReachabilityService {
    var isReachableNow: Bool {
        reachability.currentReachabilityStatus() != .NotReachable
    }
    
    func subscribe(_ delegate: ReachabilityServiceDelegate) {
        subscribers.addNotifier(delegate)
    }
    
    func unsubscribe(_ delegate: ReachabilityServiceDelegate) {
        subscribers.removeNotifier(delegate)
    }
}

private extension ReachabilityDefault {
    @objc func reachabilityStatusChaged() {
        switch reachability.currentReachabilityStatus() {
        case .NotReachable:
            subscribers |> { $0.connectionUnreachable() }
        case .ReachableViaWiFi, .ReachableViaWWAN:
            subscribers |> { $0.connectionReachable() }
        @unknown default:
            break
        }
        
    }
}
