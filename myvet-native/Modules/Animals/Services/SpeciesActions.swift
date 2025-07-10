//
//  SpeciesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class SpeciesActions {
    static func read(completion: @escaping (Result<[Species], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/species/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Species], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
