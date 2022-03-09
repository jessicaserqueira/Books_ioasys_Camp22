//
//  File.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 09/03/22.
//

import Foundation
class Book {
    var books = [String : Books]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(books) {
                UserDefaults.standard.set(encoded, forKey: "Bookmarked Books")
            }
        }
    }
    func toggleBookmarkStatus(book: Books) {
        if book.isBookmarked {
            self.books[book.id] = nil
        } else {
            self.books[book.id] = book
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Bookmarked Books") {
            if let decodedItems = try? JSONDecoder().decode([String : Books].self, from: savedItems){
                books = decodedItems
                return
            }
        }
        books = [String : Books]()
    }
}
