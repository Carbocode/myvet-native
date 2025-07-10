//
//  BcsActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class ActivityLevelsActions {
    static func read(completion: @escaping (Result<[ActivityLevel], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/activity-level/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[ActivityLevel], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
