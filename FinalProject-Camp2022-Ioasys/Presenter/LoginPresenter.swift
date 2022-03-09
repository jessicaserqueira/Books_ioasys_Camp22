//
//  PresenterViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 14/02/22.
//


import Foundation

protocol LoginViewable {
    
}

class LoginPresenter{
    
    var loginView: LoginViewable?
    var coordinator: LoginFlow?
    let service: AuthenticationServiceProtocol
    
    init (service: AuthenticationServiceProtocol, coordinator: LoginFlow, loginView: LoginViewable) {
        
        self.service = service
        self.coordinator = coordinator
        self.loginView = loginView
    }
}

extension LoginPresenter: PresenterDelegate {
    func userLogin(email: String, password: String) {
        service.authSign(user: UserModel(email: email, password: password)) { result in
            
            switch result {
            case .success(let userResponse):
                DispatchQueue.main.async {
                    self.coordinator?.showBooks(user: userResponse)
                }
            case .failure(let loginError):
                print("loginError")
            }
        }
    }
}

