//
//  BooksCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 10/02/22.
//

import UIKit

protocol BooksFlow {
    
    func showBooks(user: PersonResponse)
    func start()
    func showDetails(book: Books)
    func logout()
}

class BooksCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var userResponse: PersonResponse?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let startViewController = StartBooksViewController.initFromStoryboard()
        let presenter = BooksPresenter(coordinator: self, view: startViewController)
        
        presenter.userResponse = userResponse
        startViewController.bookPresenter = presenter
        navigationController.setViewControllers([startViewController], animated: true)
        navigationController.tabBarController?.tabBar.isHidden = false
        navigationController.setNavigationBarHidden(true, animated: true)
        
    }
}

extension BooksCoordinator: BooksFlow {
    func showDetails(book: Books) {
        let coordinator = DetailsCoordinator(navigationController: navigationController)
        coordinator.book = book
        coordinate(to: coordinator)
    }
    
    func showBooks(user: PersonResponse){
        let startCoordinator = StartBooksCoordinator(navigationController: navigationController)
        coordinate(to: startCoordinator)
        
    }
    func logout() {
        childCoordinators.removeAll()
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinate(to: coordinator)
    }
}
