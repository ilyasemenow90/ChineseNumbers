//
//  NumbersAppPresenter.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class NumbersAppPresenter {
    private let wireframe: ApplicationWireframe
    
    init(
        wireframe: ApplicationWireframe
    ) {
        self.wireframe = wireframe
    }
}

extension NumbersAppPresenter: ApplicationPresenter {
    func configure(application: Application) {
        
    }
    
    func applicationDidFinishLaunching(application: Application) {
         prepareMainFlow()
    }
    
    func applicationDidBecomeActive() {
        
    }
}

private extension NumbersAppPresenter {
    func prepareMainFlow() {
        wireframe.presentSplashScreen {
            self.runMainFlow()
        }
    }
    
    func runMainFlow() {
        wireframe.presentMainView()
    }
}
