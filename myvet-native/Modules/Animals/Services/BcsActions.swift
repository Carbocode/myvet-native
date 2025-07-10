//
//  BcsActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class BcsActions {
    static func read(completion: @escaping (Result<[Bcs], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/bcs/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Bcs], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
