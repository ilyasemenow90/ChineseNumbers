//
//  NumbersAppFactory.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

class NumbersAppFactory {
    private let networking: NetworkingComponents
    
    init() {
        networking = NetworkingComponents()
    }
}

extension NumbersAppFactory: ModuleFactory {
    func explore() -> UIViewController {
        UIViewController()
    }
    
    func details() -> UIViewController {
        UIViewController()
    }
}

extension NumbersAppFactory: ApplicationFactory {
    func main() -> UIViewController {
        guard let viewController = UIStoryboard.initialViewController(storyboardName: "Main") else { fatalError() }
        
        return viewController
    }
    
    func splashScreen(with completion: @escaping SimpleHandler) -> UIViewController {
       SplashViewController(completion)
    }
}

extension UIStoryboard {
    static func initialViewController(storyboardName: String) -> UIViewController? {
        UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
    }
}
