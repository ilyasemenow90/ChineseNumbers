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
    private var activeNumber: Number?
    
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
    
    func didSelect(number: Number) {
        updateActive(number)
        updateInterfaceForActiveNumber()
        wireframe.showDetails()
    }
}

extension ExplorePresenter: ExploreDetailsEventsHandler {
    func selectNextNumber() {
        guard
            let currentNumber = activeNumber,
            let nextActive = data.next(from: currentNumber)
        else { return }
        
        activeNumber = nextActive
    }
    
    func selectPreviousNumber() {
        guard
            let currentNumber = activeNumber,
            let nextActive = data.previous(from: currentNumber)
        else { return }
        
        activeNumber = nextActive
    }
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
    
    func updateActive(_ number: Number) {
        activeNumber = number
    }
    
    func updateInterfaceForActiveNumber() {
        guard let number = activeNumber else { return }
        
        detailsUserInterface?.update(with: number)
        masterUserInterface?.updateSelected(number: number)
    }
}
