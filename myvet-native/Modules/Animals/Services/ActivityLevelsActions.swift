//
//  BcsActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class ActivityActions {
    static func read(completion: @escaping (Result<[Bcs], Error>) -> Void) {
        Fetch.get(endpoint: "/animals/activity/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) { (result: Result<[ActivityLevels], Error>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
