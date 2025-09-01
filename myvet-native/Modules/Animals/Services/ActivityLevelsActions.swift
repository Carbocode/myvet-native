//
//  BcsActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

class ActivityLevelsActions {
    static func read() async throws -> [ActivityLevel] {
        return try await Fetch.get(endpoint: "/animals/activity-level/read", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
}
