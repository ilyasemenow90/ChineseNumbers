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
    
    private var data: [NumberModel] = []
    private var activeNumber: NumberModel?
    
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
        fillDataFromContent()
        updateMasterView()
        updateDetailView()
        
        content.updateData()
    }
    
    func didSelect(number: NumberModel) {
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
        masterUserInterface?.updateSelected(number: nextActive)
        detailsUserInterface?.update(with: nextActive)
    }
    
    func selectPreviousNumber() {
        guard
            let currentNumber = activeNumber,
            let nextActive = data.previous(from: currentNumber)
        else { return }
        
        activeNumber = nextActive
        masterUserInterface?.updateSelected(number: nextActive)
        detailsUserInterface?.update(with: nextActive)
    }
}

extension ExplorePresenter: ContentDelegate {
    func contentDidUpdate() {
        fillDataFromContent()
        updateMasterView()
        updateDetailView()
    }
    
    func contentUpdateFailed() {
        guard !content.isContentAvailable else { return }
        
        masterUserInterface?.showUpdateDataFailed()
    }
}

private extension ExplorePresenter {
    func fillDataFromContent() {
        data = content.allData().enumerated().map { NumberModel(number: $0.element, position: $0.offset) }
    }
    
    func updateMasterView() {
        masterUserInterface?.update(with: data)
    }
    
    func updateDetailView() {
        detailsUserInterface?.updatePages(count: data.count)
    }
    
    func updateActive(_ number: NumberModel) {
        activeNumber = number
    }
    
    func updateInterfaceForActiveNumber() {
        guard let number = activeNumber else { return }
        
        detailsUserInterface?.update(with: number)
        masterUserInterface?.updateSelected(number: number)
    }
}
