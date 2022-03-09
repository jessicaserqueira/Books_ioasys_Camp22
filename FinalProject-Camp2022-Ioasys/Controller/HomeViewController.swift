//
//  HomeViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 09/02/22.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInitializable {
    
    var coordinator: HomeFlow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            coordinator?.showLogin()
        }
    } 
}
