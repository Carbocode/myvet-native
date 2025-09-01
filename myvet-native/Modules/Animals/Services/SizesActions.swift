//
//  SizesActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class SizesActions {
    static func read() async throws -> [Size] {
        return try await Fetch.get(endpoint: "/animals/sizes/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}
