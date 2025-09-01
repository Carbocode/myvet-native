//
//  LoginViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import Foundation

@Observable @MainActor
class LoginViewModel {
    var loginRequest: LoginRequest = .init(Email: "", Password: "")
    var showAlert: Bool = false
    var alertMessage: String = ""
    var isLoading: Bool = false
    
    func handleLogin() {
        Task{
            // Basic validation logic
            if loginRequest.Email.isEmpty || loginRequest.Password.isEmpty {
                alertMessage = "Please enter both email and password."
                showAlert = true
            }
            else {
                do{
                    isLoading = true
                    let response = try await LoginAction.loginUser(with: loginRequest)
                    self.isLoading = false
                    
                    AuthManager.shared.saveToken(response.jwt)
                }
                catch{
                    isLoading = false
                    self.alertMessage = "Error: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
    }
}
