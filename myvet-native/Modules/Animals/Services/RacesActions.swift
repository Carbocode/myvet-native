//
//  RacesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class RacesActions {
    static func animals(idSpecie: Int, completion: @escaping (Result<[Race], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/bcs/read?IDSpecie=\(idSpecie)", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Race], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

