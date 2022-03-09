//
//  StartBooksCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 12/02/22.
//

import UIKit

protocol StartFlow {
    
    func detailsBooks()

}

class StartBooksCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
}

extension StartBooksCoordinator: StartFlow {

    func detailsBooks()  {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        coordinate(to: detailsCoordinator)
        
    }
}


