//
//  BooksPresenter.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 15/02/22.
//

import Foundation

protocol TableBooks {
    func set(books: [Books])
    
}

protocol BooksView: AnyObject {
    func implement(books: [Books])
    func implement(user: PersonResponse)
}

class BooksPresenter {
    
    weak var view: BooksView?
    var coordinator: BooksFlow?
    var userResponse: PersonResponse?
    
    init (coordinator: BooksFlow, view: BooksView) {
        self.coordinator = coordinator
        self.view = view
        
    }
}
extension BooksPresenter: BooksDelegate {
    func getUserName() {
        guard let user = userResponse else { return }
        view?.implement(user: user)
    }
    
    func updateBook() {
        
        BooksService().request { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.view?.implement(books: response.books)
                }
                
            case .failure(let error):
                print("Error")
            }
        }
    }
    func showDetail(book: Books) {
        coordinator?.showDetails(book: book)
    }
    func logout() {
        print("entrei aqui")
        coordinator?.logout()
    }
}

