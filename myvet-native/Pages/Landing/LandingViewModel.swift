//
//  LandingViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 28/08/25.
//


import Foundation
import AuthenticationServices

@Observable @MainActor
class LandingViewModel {
    var loginAppleRequest: LoginAppleRequest = .init(CodiceUtenteApple: "")
    var isLoading = false
    var showUserForm = false
    var pendingCredential: ASAuthorizationAppleIDCredential?
        
    func handleAppleLogin(cred: ASAuthorizationAppleIDCredential) {
        Task {
            defer { isLoading = false }
            do {
                loginAppleRequest.CodiceUtenteApple = cred.user
                
                let response = try await LoginAction.loginAppleUser(with: loginAppleRequest)
                AuthManager.shared.saveToken(response.jwt)
            } catch {
                pendingCredential = cred
                showUserForm = true
            }
        }
    }
}
