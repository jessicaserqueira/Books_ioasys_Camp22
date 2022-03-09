//
//  AuthenticationService.swift
//  FinalProject-Camp2022-Ioasys
//
//  Created by Jéssica Serqueira on 19/02/22.
//

import Foundation
protocol AuthenticationServiceProtocol {
    func authSign(user: UserModel, completion: @escaping (Result<PersonResponse, NetworkErrorAuth>) -> Void)
}

enum NetworkErrorAuth: String, Error {
    case badURL = "A URL não está retornado da forma desejada"
    case badUserPassword = "Usuário ou senha inválidos"
    case emailEmpty = "E-mail é obrigatório"
    case passworEmpty = "Senha é obrigatória"
    case badStatusCode = "httResponser não está retornando valores entre 200 a 299"
    case emptyAuthorization = "Não foi possível fazer a requisição utilizando a autorização"
    case unableToDecode = "Não foi possível realizar a decodificação dos objetos da API"
    case unknown = "Api não encontrada"
    
}

class AuthenticationService: AuthenticationServiceProtocol {
    func authSign(user: UserModel, completion: @escaping (Result<PersonResponse, NetworkErrorAuth>) -> Void) {

        let jsonData = try? JSONEncoder().encode(user)
        
        guard let url = URL(string: "https://books.ioasys.com.br/api/v1/auth/sign-in") else {
            completion(.failure(.badURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
            
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.emailEmpty))
                
                return
            }

            guard let data = data else {return}
            do {
                let printReponse = try
                    JSONDecoder().decode(PersonResponse.self, from: data)
                completion(.success(printReponse))
                
                if let authorization = httpResponse.allHeaderFields["Authorization"] as? String {
                    KeychainWrapper.standard.set(authorization, forKey: "Authorization-Bearer")
                } else{
                    completion(.failure(.emptyAuthorization))
                }
            
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
