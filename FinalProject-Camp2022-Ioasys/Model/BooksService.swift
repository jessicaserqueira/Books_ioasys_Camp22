//
//  CopaniesBookModel.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 15/02/22.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "A URL não está retornado da forma desejada"
    case badStatusCode = "httResponser não está retornando valores entre 200 a 299"
    case emptyAuthorization = "Não foi possível fazer a requisição utilizando a autorização"
    case unableToDecode = "Não foi possível realizar a decodificação dos objetos da API"
    case unknown = "Api nã encontrada"
    
}

class BooksService { 
    
    func request(completion: @escaping (Result<BooksResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://books.ioasys.com.br/api/v1/books?page=1&amount=25") else {
            completion(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        if let authorization = KeychainWrapper.standard.string(forKey: "Authorization-Bearer") {
            urlRequest.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        } else {
            completion(.failure(.emptyAuthorization))
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.badStatusCode))
                
                return
            }
            
            guard let data = data else {return}
            do {
                let booksRequest = try
                    JSONDecoder().decode(BooksResponse.self, from: data)
                completion(.success(booksRequest))
                
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

