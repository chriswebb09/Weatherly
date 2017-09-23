//
//  DailyForcastCell.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class DailyForcastCell: UICollectionViewCell {
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        weatherImageView.image = weatherImageView.image?.withRenderingMode(.alwaysTemplate)
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
}
