//
//  StartViewController.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate: class {
    func startNavigation(tapped: Bool)
}

class StartViewController: UIViewController, Controller {
    @IBOutlet var startView: StartView!
    
    weak var delegate: StartViewControllerDelegate?
    
    var type: ControllerType = .start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startView.logoImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(goButtonTapped(tapped:)))
        startView.logoImageView.addGestureRecognizer(tap)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func goButtonTapped(tapped: Bool) {
        print(tapped)
        delegate?.startNavigation(tapped: tapped)
    }
}
