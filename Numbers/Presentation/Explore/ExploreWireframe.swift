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
    private let factory: ModuleFactory
    
    init(context: UISplitViewController, factory: ModuleFactory) {
        self.context = context
        self.factory = factory
        
        context.delegate = self
    }
}

extension ExploreWireframe: ExploreWireframeProtocol {
    func showDetails(with context: DetailsContext) {

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
