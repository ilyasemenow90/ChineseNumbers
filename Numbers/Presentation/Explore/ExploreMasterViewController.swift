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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsHandler?.didLoadView()
    }
}

extension ExploreMasterViewController: ExploreMasterUserInterface {
    func update(with data: [Number]) {
        
    }
}
