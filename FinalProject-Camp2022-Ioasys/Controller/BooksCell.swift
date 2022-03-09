//
//  BooksCell.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 13/02/22.
//

import UIKit

protocol FavoriteBookDelegate: AnyObject {
    func bookFavoriteDelegate()
    
}

class BooksCell: UITableViewCell {
    
    
    weak var delegate: FavoriteBookDelegate?
    var isFavorite: Bool = false{
        didSet{
            favoriteButton.setImage(isFavorite ? UIImage(systemName: "bookmark") : UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    }

    @IBOutlet var imageBook: UIImageView!
    @IBOutlet var stackBook: UIStackView!
    @IBOutlet var titleBook: UILabel!
    @IBOutlet var authorBook: UILabel!
    @IBOutlet var pageBook: UILabel!
    @IBOutlet var publisherBook: UILabel!
    @IBOutlet var publishedBook: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        delegate?.bookFavoriteDelegate()
                isFavorite.toggle()
    }
}

extension UIImageView {
    func load(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
                
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
