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
    
    private var number: Number?
    private var isAwaken: Bool = false
    
    var eventsHandler: ExploreDetailsEventsHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isAwaken = true
        updateUI()
    }
}

extension ExploreDetailsViewController: ExploreDetailsUserInterface {
    func update(with number: Number) {
        self.number = number
        updateUI()
    }
}

private extension ExploreDetailsViewController {
    func updateUI() {
        guard isAwaken else { return }
        
        titleLabel.text = number?.name
        if let url = number?.image {
            imageView.loadImage(from: url)
        }
    }
}
