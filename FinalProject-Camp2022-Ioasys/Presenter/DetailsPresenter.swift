//
//  DetailsPresenter.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 17/02/22.
//

import Foundation

protocol DetailViewable: AnyObject {
    func implement(book: Books)
}

class DetailsPresenter {
    
    var coordinator: DetailsFlow
    weak var view: DetailViewable?
    var book: Books?
    
    init (coordinator: DetailsFlow, view: DetailViewable) {
        self.coordinator = coordinator
        self.view = view
        
    }
}
extension DetailsPresenter: DetailPresenting {
    func getBook() {
        guard let book = book else { return }
        view?.implement(book: book)
    }
}


