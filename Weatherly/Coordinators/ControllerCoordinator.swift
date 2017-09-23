//
//  ControllerCoordinator.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

enum  ControllerType {
    case app, start, none
}

protocol Controller: class {
    var type: ControllerType { get }
}

protocol ControllerCoordinatorDelegate: CoordinatorDelegate {
    func transitionCoordinator(type: CoordinatorType)
}

typealias RootController = UIViewController & Controller

protocol ControllerCoordinator: Coordinator {
    var window: UIWindow { get set }
    var rootController: RootController! { get }
    weak var delegate: ControllerCoordinatorDelegate? { get set }
}
