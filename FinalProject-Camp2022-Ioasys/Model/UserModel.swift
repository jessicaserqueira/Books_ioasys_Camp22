//
//  UserModel.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 08/02/22.
//

import Foundation

struct  UserModel: Encodable {
        
        let email: String
        let password: String
        
    }

    struct PersonResponse: Decodable {
                
        let name: String
        let email: String
        let birthdate: String
        let gender: String
        let id: String
        
    }

struct BooksResponse: Decodable {
    
    let books: [Books]
    
    enum CodingKeys: String, CodingKey {
        case books = "data"
        
    }
}

struct Books: Codable, Equatable  {
    
    var authors: [String]?
    let title: String?
    let description: String?
    let pageCount: Int?
    let category: String?
    let imageUrl: String?
    let language: Language
    let isbn10: String?
    let isbn13: String?
    let publisher: String?
    let published: Int?
    let id: String
    
}

enum Language: String, Codable {
    case ingles = "Inglês"
    case português = "Português"
}

extension Books {
    var isBookmarked: Bool {
        Book().books[self.id] == self
    }
}
