//
//  LoginActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import Foundation

class LoginAction {
    static func loginUser(with request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        Fetch.post(endpoint: "/accounts/login", body: request) { (result: Result<LoginResponse, Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response)) // ✅ Restituiamo solo il body con il JWT
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
