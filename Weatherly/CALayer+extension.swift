//
//  CALayer+extension.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setCellShadow(contentView: UIView) {
        let shadowOffsetWidth: CGFloat = contentView.bounds.height * CALayerConstants.shadowWidthMultiplier
        let shadowOffsetHeight: CGFloat = contentView.bounds.width * CALayerConstants.shadowHeightMultiplier
        shadowColor = UIColor.black.cgColor
        shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        shadowRadius =  6
        shadowOpacity = 0.9
    }
    
    static func buildGradientLayer(with colors: [CGColor], bounds: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        return gradientLayer
    }
}

struct CALayerConstants {
    static let shadowWidthMultiplier: CGFloat = 0.001
    static let shadowHeightMultiplier: CGFloat = 0.001
}
