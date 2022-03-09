//
//  LoginCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 09/02/22.
//

import UIKit

protocol LoginFlow {
    
    func showBooks(user: PersonResponse)
    func start()

}

class LoginCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = LoginViewController.initFromStoryboard()
        
        let booksCoordinator = BooksCoordinator(navigationController: navigationController)
        startViewController.presenter = LoginPresenter(service: AuthenticationService(), coordinator: self, loginView: startViewController)
        startViewController.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.tabBarController?.tabBar.isHidden = true
        navigationController.pushViewController(startViewController, animated: true)
        
    }
}

extension LoginCoordinator: LoginFlow {
    
    func showBooks(user: PersonResponse) {
        let coordinator = BooksTabBarCoordinator(navigationController: navigationController, tabBarController: UITabBarController())
        coordinator.userResponse = user
        coordinate(to: coordinator)
    }
 
}
