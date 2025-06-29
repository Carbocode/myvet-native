//
//  MyPetActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 04/03/25.
//

import Foundation

class AnimalsActions {
    static func animals(completion: @escaping (Result<[Animal], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/read-all", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[Animal], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    static func animal(id: Int, completion: @escaping (Result<Animal, Error>) -> Void) {
        Fetch.get(endpoint: "/animals/read?id=\(id)", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<Animal, Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
