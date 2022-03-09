//
//  HomeCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 09/02/22.
//

import UIKit

protocol HomeFlow {
    
    func showLogin()
}

class HomeCoordinator: Coordinator {    
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = HomeViewController.initFromStoryboard()
        startViewController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(startViewController, animated: true)
    }
}

extension HomeCoordinator: HomeFlow {
    
    func showLogin() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: loginCoordinator)
    }
}
