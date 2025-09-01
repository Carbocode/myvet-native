//
//  LoginActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import Foundation

class LoginAction {
    static func loginUser(with request: LoginRequest) async throws -> LoginResponse {
        return try await Fetch.post(endpoint: "/accounts/login", body: request)
    }
    
    static func loginAppleUser(with request: LoginAppleRequest) async throws -> LoginResponse {
        return try await Fetch.post(endpoint: "/accounts/login-apple", body: request)
    }
}
