//
//  ViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 06/02/22.
//

import UIKit

protocol PresenterDelegate {
    func userLogin(email: String, password: String)
    
}

class LoginViewController: UIViewController, StoryboardInitializable {
    
   
    @IBOutlet var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    var bookPresenter: BooksDelegate?
    var presenter: PresenterDelegate?
    var coordinator: LoginFlow?
    var loginView: LoginViewable?
    var iconClick = false
    let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableSecurityEntry()
    }
    
    func disableSecurityEntry(){
        imageIcon.image = UIImage(systemName: "eye")
        
        
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        imageIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye")!.size.width, height: UIImage(systemName: "eye")!.size.height)
        
        senha.rightView = contentView
        senha.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:
                                                            #selector(imageTapped(tapGestureRecognizer:)))
        
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(systemName: "eye")
            senha.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            senha.isSecureTextEntry = true
        }
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = email.text else { return }
        guard let senha = senha.text else { return }
        
        presenter?.userLogin(email: email, password: senha)
        
    }
}

extension LoginViewController: LoginViewable {
    
}

