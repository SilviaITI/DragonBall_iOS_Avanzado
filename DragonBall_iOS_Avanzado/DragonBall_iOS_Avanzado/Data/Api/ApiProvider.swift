//
//  ApiProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 13/10/23.
//

import UIKit
protocol ApiProviderProtocol {
   func login(for email: String, with password: String)
}
class ApiProvider: ApiProviderProtocol {
    private static let urlBase = "https://dragonball.keepcoding.education/api"
    
    private enum Endpoint {
        static let login = "/auth/login"
        static let getHeroes = "/heros"
        static let getTransformations = "transformations"
    }
    
    func login(for email: String, with password: String) {
        guard let url = URL(string: "\(ApiProvider.urlBase),\(Endpoint.login)") else {
            return
        }
        guard let loginData = String(format: "%@:%@", email, password).data(using: .utf8)?.base64EncodedData() else {
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "HTTPS"
        urlRequest.setValue("Bascic \(loginData)",
                            forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // print("Login response: \(String(describing: response))")
            guard error == nil else {
                
                return
            }
            guard let data,
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                return
            }
            guard let responseData = String(data: data, encoding: .utf8) else {
                return
            }
        }
    }
    
}
