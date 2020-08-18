//
//  NumbersAppFactory.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case exploreMaster = "ExploreMaster"
    case exploreDetails = "ExploreDetails"
}

class NumbersAppFactory {
    private let networking: NetworkingComponents
    private let storage: StorageComponents
    private let content: ContentComponents
    
    init() {
        networking = NetworkingComponents()
        storage = StorageComponents()
        
        content = ContentComponents(storage: storage, networking: networking)
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
        guard
            let masterViewController = UIStoryboard.initialViewController(from: .exploreMaster) as? ExploreMasterViewController,
            let detailsViewController = UIStoryboard.initialViewController(from: .exploreDetails) as? ExploreDetailsViewController
        else { fatalError() }
        
        let masterNavigationController = UINavigationController(rootViewController: masterViewController)
        let detailNavigationController = UINavigationController(rootViewController: detailsViewController)

        let splitViewController = UISplitViewController()
        splitViewController.viewControllers = [masterNavigationController, detailNavigationController]
        
        let wireframe = ExploreWireframe(context: splitViewController)
        let presenter = ExplorePresenter(
            wireframe: wireframe,
            content: content.resolve(Content.self)
        )
        
        presenter.masterUserInterface = masterViewController
        presenter.detailsUserInterface = detailsViewController
        
        masterViewController.eventsHandler = presenter
        detailsViewController.eventsHandler = presenter
        
        return splitViewController
    }
    
    func splashScreen(with completion: @escaping SimpleHandler) -> UIViewController {
       SplashViewController(completion)
    }
}

extension UIStoryboard {
    static func initialViewController(from storyboardName: StoryboardName) -> UIViewController? {
        UIStoryboard(name: storyboardName.rawValue, bundle: nil).instantiateInitialViewController()
    }
}
