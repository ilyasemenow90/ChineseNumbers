//
//  ExploreWireframe.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

final class ExploreWireframe {
    private let context: UISplitViewController
    
    init(context: UISplitViewController) {
        self.context = context
        
        context.delegate = self
    }
}

extension ExploreWireframe: ExploreWireframeProtocol {
    func showDetails() {
        
    }
}

extension ExploreWireframe: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        true
    }
}
