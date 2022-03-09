//
//  DetailsCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 11/02/22.
//

import UIKit
protocol DetailsFlow {
    func detailsBooks()
}

class DetailsCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var book: Books?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = DetailsViewController.initFromStoryboard()
        let presenter = DetailsPresenter(coordinator: self, view: viewController)
        presenter.book = book
        viewController.presenter = presenter
        viewController.modalPresentationStyle = .popover
        viewController.modalTransitionStyle = .crossDissolve
        navigationController.present(viewController, animated: true, completion: nil)
        
    }
}

extension DetailsCoordinator: DetailsFlow {
    func detailsBooks() {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        coordinate(to: detailsCoordinator)
    }
}
