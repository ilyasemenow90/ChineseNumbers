//
//  SplashViewController.swift
//  Numbers
//
//  Created by Ilya on 8/17/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    private var completion: SimpleHandler?

    init(_ completion: SimpleHandler? = nil) {
        self.completion = completion

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let background = UIView()
        background.backgroundColor = .white

        view = background
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.completion?()
        }
    }
}

