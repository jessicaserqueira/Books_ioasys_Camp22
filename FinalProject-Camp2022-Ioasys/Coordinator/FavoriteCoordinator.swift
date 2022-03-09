//
//  FavoriteCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 11/02/22.
//

import UIKit

protocol FavoriteFlow {
    
    func favoriteBook()
}

class FavoriteCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var book: Books?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = FavoriteViewController.initFromStoryboard()
        let presenter = FavoritePresenter(coordinator: self, view: startViewController)
        presenter.book = book
        startViewController.presenter = presenter
        
        navigationController.setViewControllers([startViewController], animated: true)
        navigationController.tabBarController?.tabBar.isHidden = false
        navigationController.setNavigationBarHidden(true, animated: true)
    }
}

extension FavoriteCoordinator: FavoriteFlow {
    func favoriteBook() {

        let favoriteCoordinator = FavoriteCoordinator(navigationController: navigationController)
        coordinate(to: favoriteCoordinator)
    }
}
