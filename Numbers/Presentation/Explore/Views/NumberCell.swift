//
//  NumberCell.swift
//  Numbers
//
//  Created by Ilya on 8/18/20.
//  Copyright © 2020 Ilya Semenow. All rights reserved.
//

import Foundation
import UIKit

enum NumberCellState {
    case selected
    case highlighted
    case none
}

final class NumberCell: UICollectionViewCell {
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var imageView: UIImageView!
    
    private static var hasSelectedState: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
    }
    
    func update(title: String) {
        titleLabel.text = title
    }
    
    func update(url: URL) {
        imageView.loadImage(from: url)
    }
    
    func update(state: NumberCellState) {
        switch state {
        case .highlighted:
            backgroundColor = ColorPalette.mainBackgroundHighlighted
        case .selected:
            guard Self.hasSelectedState else {
                backgroundColor = ColorPalette.mainBackground
                return
            }
            backgroundColor =  ColorPalette.mainBackgroundSelected
        case .none:
            backgroundColor = ColorPalette.mainBackground
        }
    }
}
