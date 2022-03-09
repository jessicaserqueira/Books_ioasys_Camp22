//
//  AppCoordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 09/02/22.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var navigationController: UINavigationController
    var navigationBarController: UINavigationBar
    var childCoordinators: [Coordinator] = []
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.navigationBarController = UINavigationBar()
        
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let mainCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinate(to: mainCoordinator)
    }
}
