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
    private weak var context: UISplitViewController?
    private weak var details: UIViewController?
    private let factory: ModuleFactory
    
    init(context: UISplitViewController, details: UIViewController, factory: ModuleFactory) {
        self.context = context
        self.details = details
        self.factory = factory
        
        context.delegate = self
    }
}

extension ExploreWireframe: ExploreWireframeProtocol {
    func showDetails() {
        guard let splitVC = self.context, let secondaryVC = details else { return }
        
        splitVC.showDetailViewController(secondaryVC, sender: nil)
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
