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
    
    private var numbers: [Number] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsHandler?.didLoadView()
    }
}

extension ExploreMasterViewController: ExploreMasterUserInterface {
    func update(with data: [Number]) {
        numbers = data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ExploreMasterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let number = numbers[safe: indexPath.count] else { return }
        
        eventsHandler?.didSelect(number: number)
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
            let number = numbers[safe: indexPath.item]
        else { fatalError() }
        
        cell.update(title: number.name)
        
        return cell
    }
}
