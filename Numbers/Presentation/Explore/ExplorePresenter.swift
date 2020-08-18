//
//  ExplorePresenter.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

final class ExplorePresenter {
    private let wireframe: ExploreWireframeProtocol
    private let content: Content
    
    private var data: [Number] = []
    
    weak var masterUserInterface: ExploreMasterUserInterface?
    weak var detailsUserInterface: ExploreDetailsUserInterface?
    
    init(
        wireframe: ExploreWireframeProtocol,
        content: Content
    ) {
        self.wireframe = wireframe
        self.content = content
        
        content.subscribe(self)
    }
}

extension ExplorePresenter: ExploreMasterEventsHandler {
    func didLoadView() {
        data = content.allData()
        updateMasterView()
        
        content.updateData()
    }
    
    func didSelectItem() {
        
    }
}

extension ExplorePresenter: ExploreDetailsEventsHandler {
    
}

extension ExplorePresenter: ContentDelegate {
    func contentDidUpdate() {
        data = content.allData()
        updateMasterView()
    }
}

private extension ExplorePresenter {
    func updateMasterView() {
        masterUserInterface?.update(with: data)
    }
}
