//
//  ContentFacade.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

final class ContentFacade {
    private let updater: ContentUpdater
    private let storage: ContentStorage
    private let reachability: ReachabilityService
    
    private let subscribers: Notifier<ContentDelegate>
    
    private var isDataUpdated: Bool = false
    
    init(
        updater: ContentUpdater,
        storage: ContentStorage,
        reachability: ReachabilityService
    ) {
        self.updater = updater
        self.storage = storage
        self.reachability = reachability
  
        subscribers = Notifier()
        
        reachability.subscribe(self)
    }
}

extension ContentFacade: Content {
    var isContentAvailable: Bool { storage.isDataAvailable }
    
    func updateData() {
        guard !updater.isUpdateActive else { return }
        
        updater.updateData { result in
            switch result {
            case .success(let numbers):
                self.storage.store(data: numbers)
                self.subscribers |> { $0.contentDidUpdate() }
            case .failure:
                self.subscribers |> { $0.contentUpdateFailed() }
            }
        }
    }
    
    func subscribe(_ delegate: ContentDelegate) {
        subscribers.addNotifier(delegate)
    }
    
    func unsubscribe(_ delegate: ContentDelegate) {
        subscribers.removeNotifier(delegate)
    }
    
    func allData() -> [Number] {
        storage.getAllData()
    }
}

extension ContentFacade: ReachabilityServiceDelegate {
    func connectionReachable() {
        guard !isDataUpdated else { return }
        
        updateData()
    }
    
    func connectionUnreachable() { }
}

private extension ContentFacade {
}
