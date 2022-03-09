//
//  DetailsViewController.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 11/02/22.
//

import UIKit

protocol DetailPresenting {
    func getBook()
}

class DetailsViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet var imageDetails: UIImageView!    

    @IBOutlet var titleDetails: UILabel!
    @IBOutlet var authorDetails: UILabel!
    @IBOutlet var pageDeteails: UILabel!
    @IBOutlet var publishedDetails: UILabel!
    @IBOutlet var publisherDetails: UILabel!
    @IBOutlet var linguageDetails: UILabel!
    @IBOutlet var OriginalTitleDetails: UILabel!
    @IBOutlet var isbn10Details: UILabel!
    @IBOutlet var isbn13Details: UILabel!
    @IBOutlet var descriptionDetails: UILabel!

    var books: Books?
    var presenter: DetailPresenting?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        presenter?.getBook()
    }
}


// MARK: - BooksView

extension DetailsViewController: DetailViewable {
    func implement(book: Books) {
        guard let imageURL = book.imageUrl else { return }
        imageDetails.load(urlString: imageURL)
        titleDetails.text = book.title
        let author = [book.authors]
        
        for _ in author {
            authorDetails.text = book.authors?.joined(separator: ", ")
        }
        
        pageDeteails.text = String(book.pageCount ?? 0)
        publisherDetails.text = book.publisher
        publishedDetails.text = String(book.published ?? 0)
        linguageDetails.text = book.language.rawValue
        OriginalTitleDetails.text = book.title
        isbn10Details.text = book.isbn10
        isbn13Details.text = book.isbn13
        descriptionDetails.text = book.description
    }  
}
