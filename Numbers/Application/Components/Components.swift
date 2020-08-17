//
//  Components.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class Components {
    private var singletons: [Any] = []

    func singleton<T: Any>(_ construction: () -> T) -> T {
        if let constructed = singletons.first(where: {
            $0 is T
        }) {
            guard let instance = constructed as? T else { fatalError() }

            return instance
        } else {
            let constructed = construction()
            singletons.append(constructed)
            return constructed
        }
    }
}
