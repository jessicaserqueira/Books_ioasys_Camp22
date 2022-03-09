//
//  BooksTabBarCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 16/02/22.
//

import UIKit

protocol BooksTabBarFlow { }

class BooksTabBarCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var childCoordinators: [Coordinator] = []
    var userResponse: PersonResponse?
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let booksCoordinator = makeBooksCoordinator()
        let favoriteCoordinator = makeFavoriteCoordinator()
        
        childCoordinators.append(booksCoordinator)
        childCoordinators.append(favoriteCoordinator)
        
        tabBarController.setViewControllers([booksCoordinator.navigationController, favoriteCoordinator.navigationController],
                                            animated: true)
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    private func makeBooksCoordinator() -> BooksCoordinator {
        let coordinator = BooksCoordinator(navigationController: UINavigationController())
        coordinator.userResponse = userResponse
        coordinator.start()
        
        return coordinator
    }
    
    private func makeFavoriteCoordinator() -> FavoriteCoordinator {
        let coordinator = FavoriteCoordinator(navigationController: UINavigationController())
        
        coordinator.start()
        
        return coordinator
    }
}

extension BooksTabBarCoordinator: BooksTabBarFlow {
    
}
