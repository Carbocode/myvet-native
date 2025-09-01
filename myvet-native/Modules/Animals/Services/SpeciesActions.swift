//
//  SpeciesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class SpeciesActions {
    static func read() async throws -> [Species] {
        return try await Fetch.get(endpoint: "/animals/species/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}
