//
//  ExploreMasterViewController.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

final class ExploreMasterViewController: UIViewController {
    var eventsHandler: ExploreMasterEventsHandler?
    
    @IBOutlet private(set) var collectionView: UICollectionView!
    @IBOutlet private(set) var missingDataView: UIView!
    @IBOutlet private(set) var missingDataLabel: UILabel!
    
    private var numbers: [NumberModel] = []
    private var selectedNumber: NumberModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delaysContentTouches = false
        collectionView.allowsSelection = true
        
        eventsHandler?.didLoadView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
}

extension ExploreMasterViewController: ExploreMasterUserInterface {
    func update(with data: [NumberModel]) {
        numbers = data
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            if !self.numbers.isEmpty {
                self.missingDataView.isHidden = true
            }
        }
    }
    
    func updateSelected(number: NumberModel) {
        selectedNumber = number
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showUpdateDataFailed() {
        DispatchQueue.main.async {
            self.missingDataLabel.text = NSLocalizedString("network.error.general.message", comment: "")
        }
    }
}

extension ExploreMasterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let number = numbers[safe: indexPath.item] else { return }
        
        eventsHandler?.didSelect(number: number)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? NumberCell {
            cell.update(state: .selected)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell else { return }
        
        cell.update(state: .none)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell else { return }
            
        cell.update(state: .highlighted)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? NumberCell else { return }
        
        guard let number = numbers[safe: indexPath.item], number == selectedNumber else {
            cell.update(state: .none)
            return
        }
        
        cell.update(state: .selected)
    }
}

extension ExploreMasterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        CGSize(width: collectionView.bounds.size.width, height: 64)
    }
}

extension ExploreMasterViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NumbersCell", for: indexPath) as? NumberCell,
            let model = numbers[safe: indexPath.item]
        else { fatalError() }
        
        cell.update(title: model.number.name)
        cell.update(url: model.number.image)
        
        if model == selectedNumber {
            cell.update(state: .selected)
        } else {
            cell.update(state: .none)
        }
        
        
        return cell
    }
}
