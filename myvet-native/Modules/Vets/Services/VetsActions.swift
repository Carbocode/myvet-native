//
//  VetActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 18/07/25.
//

import Foundation

class VetsActions {
    static func readFavorites() async throws -> [Vet] {
        return try await Fetch.get(endpoint: "/vets/read-all", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
    
    static func readProfile() async throws -> [Vet] {
        return try await Fetch.get(endpoint: "/vets/read-all", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }

    
    static func updateFavorite(request: FavoriteRequest) async throws {
        _ = try await Fetch.post(endpoint: "/vets/favorite/update", body: request, headers: ["Authorization": AuthManager.shared.getToken() ?? ""]) as EmptyResponse
    }
}   
