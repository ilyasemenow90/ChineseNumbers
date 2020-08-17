//
//  NumbersAppWireframe.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

class NumbersAppWireframe {
    private weak var context: UIWindow?
    private var factory: ApplicationFactory

    init(context: UIWindow?, factory: ApplicationFactory) {
        self.context = context
        self.factory = factory
    }
}

extension NumbersAppWireframe: ApplicationWireframe {
    func presentSplashScreen(_ completion: @escaping SimpleHandler) {
        let rootViewController = factory.splashScreen(with: completion)
        context?.rootViewController = rootViewController
        context?.makeKeyAndVisible()
    }
    
    func presentMainView() {
        let rootViewController = factory.main()
        context?.rootViewController = rootViewController
        context?.makeKeyAndVisible()
    }
}
