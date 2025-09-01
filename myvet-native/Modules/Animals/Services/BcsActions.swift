//
//  BcsActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class BcsActions {
    static func read() async throws -> [Bcs] {
        return try await Fetch.get(endpoint: "/animals/bcs/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}
