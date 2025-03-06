//
//  LoginViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var loginRequest: LoginRequest = .init(Email: "", Password: "")
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var isLoading: Bool = false
    
    func handleLogin() {
        // Basic validation logic
        if loginRequest.Email.isEmpty || loginRequest.Password.isEmpty {
            alertMessage = "Please enter both email and password."
            showAlert = true
        }
        else {
            // Proceed with login logic (e.g., API call)
            isLoading = true
            LoginAction.loginUser(with: loginRequest) { result in
                self.isLoading = false
                switch result {
                case .success(let response):
                    AuthManager.shared.saveToken(response.jwt)
                case .failure(let error):
                    self.alertMessage = "Error: \(error.localizedDescription)"
                    self.showAlert = true
                }
            }
        }
        
        
    }
    
}
