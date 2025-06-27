//
//  SizesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class SizesActions {
    static func animals(completion: @escaping (Result<[Size], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/bcs/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Size], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
