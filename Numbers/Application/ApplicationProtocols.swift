//
//  ApplicationProtocols.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

protocol ApplicationWindow: AnyObject {
    var mainWindow: UIWindow? { get set }
}

protocol ApplicationFactory {
    func splashScreen(with: @escaping SimpleHandler) -> UIViewController
    func main() -> UIViewController
}

protocol ModuleFactory {
}

protocol ApplicationWireframe {
    func presentSplashScreen(_ completion: @escaping SimpleHandler)
    func presentMainView()
}

protocol ApplicationPresenter {
    func configure(application: Application)
    func applicationDidFinishLaunching(application: Application)
    func applicationDidBecomeActive()
}

protocol ApplicationPresenterApplicant: ApplicationWindow {
    var presenter: ApplicationPresenter? { get set }
}
