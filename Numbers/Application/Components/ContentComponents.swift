//
//  ContentComponents.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class ContentComponents: Components {
    private let storage: StorageComponents
    private let networking: NetworkingComponents
    
    init(storage: StorageComponents, networking: NetworkingComponents) {
        self.storage = storage
        self.networking = networking
    }
    
    func resolve(_: Content.Protocol) -> Content {
        ContentFacade(
            updater: resolve(ContentUpdater.self),
            storage: storage.resolve(ContentStorage.self),
            reachability: networking.resolve(ReachabilityService.self)
        )
    }
    
    func resolve(_: ContentUpdater.Protocol) -> ContentUpdater {
        ContentNetworkUpdater(
            httpService: HttpService(),
            dataParser: storage.resolve(NubmersParser.self))
    }
}
