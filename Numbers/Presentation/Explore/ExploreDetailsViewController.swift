//
//  ExploreDetailsViewController.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

final class ExploreDetailsViewController: UIViewController {
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var imageView: UIImageView!
    @IBOutlet private(set) var pageContorol: UIPageControl!
    
    private var model: NumberModel?
    private var isAwaken: Bool = false
    
    var eventsHandler: ExploreDetailsEventsHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAwaken = true
        
        pageContorol.isHidden = true
        updateUI()
    }
}

extension ExploreDetailsViewController: ExploreDetailsUserInterface {
    func updatePages(count: Int) {
        guard isAwaken else { return }
        
        DispatchQueue.main.async {
            self.pageContorol.numberOfPages = count
        }
    }
    
    func update(with model: NumberModel) {
        self.model = model
        updateUI()
    }
}

private extension ExploreDetailsViewController {
    func updateUI() {
        guard isAwaken else { return }
        
        titleLabel.text = model?.number.name
        if let url = model?.number.image {
            imageView.loadImage(from: url)
        }
        
        updatePageControlWithActiveModel()
        
    }
    
    func updatePageControlWithActiveModel() {
        guard let activeModel = model else { return }
            
        pageContorol.isHidden = false
        pageContorol.currentPage = activeModel.position
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        eventsHandler?.selectNextNumber()
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        eventsHandler?.selectPreviousNumber()
    }
}
