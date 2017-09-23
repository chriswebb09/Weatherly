//
//  MainForcastView.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MainForcastView: UIView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    func setCurrentTemp(temp: String) {
        currentTemperatureLabel.text = temp
    }
    
    func setWeatherDescription(description: String) {
        weatherDescriptionLabel.text = "\(description)"
    }
    
    func setWeatherIcon(icon: UIImage) {
        weatherImage.image = icon.withRenderingMode(.alwaysTemplate)
        weatherImage.tintColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradient = CALayer.buildGradientLayer(with: [UIColor.blue.cgColor, UIColor.cyan.cgColor], bounds: backgroundView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
    }
}
