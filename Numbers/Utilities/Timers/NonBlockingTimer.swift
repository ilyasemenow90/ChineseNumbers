//
//  NonBlockingTimer.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation

class NonBlockingTimer {
    class func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: Any, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> Timer {
        let timer = Timer(timeInterval: ti, target: aTarget, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
        RunLoop.current.add(timer, forMode: .common)
        return timer
    }

    @available(iOS 10.0, *)
    class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        let timer = Timer(timeInterval: interval, repeats: repeats, block: block)
        RunLoop.current.add(timer, forMode: .common)
        return timer
    }
}
