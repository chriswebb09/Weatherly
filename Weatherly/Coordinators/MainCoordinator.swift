//
//  MainCoordinator.swift
//  Weatherly
//
//  Created by Christopher Webb-Orenstein on 9/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MainCoordinator: AppCoordinator {
    
    weak var delegate: ControllerCoordinatorDelegate?
    
    var childCoordinators: [ControllerCoordinator] = []
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        transitionCoordinator(type: .start)
    }
    
    func add(_ childCoordinator: ControllerCoordinator) {
        childCoordinator.delegate = self
        childCoordinators.append(childCoordinator)
    }
    
    func remove(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

extension MainCoordinator: ControllerCoordinatorDelegate {
    
    // Switch between application flows
    
    func transitionCoordinator(type: CoordinatorType) {
        
        // Remove previous application flow
        
        childCoordinators.removeAll()
        
        switch type {
            
        case .app:
            let forcastCoordinator = ForcastControllerCoordinator(window: window)
            add(forcastCoordinator)
            forcastCoordinator.delegate = self
            forcastCoordinator.type = .app
            forcastCoordinator.start()
            
        case .start:
            let startCoordinator = StartControllerCoordinator(window: window)
            add(startCoordinator)
            startCoordinator.delegate = self
            startCoordinator.type = .start
            startCoordinator.start()
            dump(startCoordinator)
        }
    }
}
