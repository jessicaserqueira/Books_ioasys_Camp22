//
//  FavoritePresenter.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 18/02/22.
//

import Foundation

protocol FavoriteViewable: AnyObject {
    func implement(book: Books)
}

class FavoritePresenter {
    
    var coordinator: FavoriteFlow
    weak var view: FavoriteViewable?
    var book: Books?
    
    init (coordinator: FavoriteFlow, view: FavoriteViewable) {
        self.coordinator = coordinator
        self.view = view
    }
}
extension FavoritePresenter: FavoritePresenting {
    func bookFavorite() {
        guard let book = book else { return }
        view?.implement(book: book)
    }
}

