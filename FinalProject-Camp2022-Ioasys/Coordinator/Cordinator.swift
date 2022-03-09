//
//  Cordinator.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 08/02/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
