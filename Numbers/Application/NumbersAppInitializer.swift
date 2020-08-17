//
//  NumbersAppInitializer.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

class NumbersAppInitializer {
    func initialize(application: Application, delegate: ApplicationPresenterApplicant) {
        let window = UIWindow()
        delegate.mainWindow = window

        let factory = NumbersAppFactory()

        let wireframe = NumbersAppWireframe(context: window, factory: factory)
        let presenter = NumbersAppPresenter(
            wireframe: wireframe
        )
        delegate.presenter = presenter

        presenter.configure(application: application)
    }
}
