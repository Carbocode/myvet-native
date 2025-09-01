//
//  ServiceActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

import Foundation


class VetSericesActions {
    static func readFavorite(idVeterinario: Int) async throws -> [VetService] {
        return try await Fetch.get(
            endpoint: "/vets/services/favourite/read",
            queryParams:  [URLQueryItem(name: "IDVeterinario", value: String(idVeterinario))],
            headers: ["Authorization": AuthManager.shared.getToken() ?? ""]
        )
    }
}
