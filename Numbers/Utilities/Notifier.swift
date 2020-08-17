//
//  Notifier.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class Notifier<T> {
    private let delegates = NSHashTable<AnyObject>.weakObjects()
    
    func addNotifier(_ delegate: T) {
        delegates.add(delegate as AnyObject)
    }
    
    func removeNotifier(_ delegate: T) {
        delegates.remove(delegate as AnyObject)
    }
    
    func notify(_ invocation: (T) -> ()) {
        delegates.allObjects.forEach { notify in
            guard let delegate = notify as? T else { return }
            
            invocation(delegate)
        }
    }
}

precedencegroup NotifyPrecedence {
    associativity: left
    higherThan: TernaryPrecedence
}
infix operator |> : NotifyPrecedence
func |><T>(left: Notifier<T>, right: (T) -> ()) {
    left.notify(right)
}
