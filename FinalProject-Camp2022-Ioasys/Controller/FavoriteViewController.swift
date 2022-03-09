//
//  FavoriteViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 10/02/22.
//

import UIKit

protocol FavoritePresenting {
    func bookFavorite()
}

class FavoriteViewController: UIViewController, StoryboardInitializable {

    
    @IBOutlet var tableView: UITableView!
  
    var books: Books?
    var presenter: FavoritePresenting?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.bookFavorite()
    }
}

// MARK: - BooksView

extension FavoriteViewController: FavoriteViewable {
    func implement(book: Books) {
        
    }
}
