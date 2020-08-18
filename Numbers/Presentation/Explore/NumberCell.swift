//
//  NumberCell.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

final class NumberCell: UICollectionViewCell {
    @IBOutlet private(set) var titleLabel: UILabel!
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                backgroundColor = ColorPalette.mainBackgroundHighlighted
            } else {
                backgroundColor = ColorPalette.mainBackground
            }
        }
    }
    
    func update(title: String) {
        titleLabel.text = title
    }
}
