//
//  RacesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class RacesActions {
    static func read(idSpecie: Int) async throws -> [Race] {
        let queryParams: [URLQueryItem] = [URLQueryItem(name: "IDSpecie", value: String(idSpecie))]
        return try await Fetch.get(endpoint: "/animals/races/read", queryParams: queryParams, headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}

