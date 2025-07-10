//
//  RacesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class RacesActions {
    static func read(idSpecie: Int, completion: @escaping (Result<[Race], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/races/read", queryParams: [URLQueryItem(name: "IDSpecie", value: String(idSpecie))], headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Race], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

