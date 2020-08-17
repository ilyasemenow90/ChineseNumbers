//
//  NumbersAppDelegate.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import UIKit

class NumbersAppDelegate: UIResponder, UIApplicationDelegate, ApplicationPresenterApplicant {
    var window: UIWindow?
    var mainWindow: UIWindow? {
        get {
            window
        }
        set {
            let oldValue = window
            window = newValue
            newValue?.makeKeyAndVisible()

            if let oldValue = oldValue, let newValue = newValue {
                UIView.transition(
                    with: newValue,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: nil
                ) { _ in
                    oldValue.isHidden = true
                }
            } else {
                newValue?.makeKeyAndVisible()
            }
        }
    }

    var presenter: ApplicationPresenter?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let application = application as? Application else { fatalError() }
        
        let initializer = NumbersAppInitializer()
        initializer.initialize(application: application, delegate: self)
        
        presenter?.applicationDidFinishLaunching(application: application)
        
        return true
    }
}

