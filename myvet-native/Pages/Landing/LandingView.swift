//
//  LandingView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI
import AuthenticationServices

struct LandingView: View {
    @State private var viewModel = LandingViewModel()
    
    @State private var showUserForm = false
    @State private var appleCreds: ASAuthorizationAppleIDCredential?

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink("Login") {
                    LoginView()
                }
                .tint(.blue)
                .buttonStyle(.glass)
                .disabled(viewModel.isLoading)

                NavigationLink("Registrazione") {
                    UserFormView()
                }
                .tint(.blue)
                .buttonStyle(.glass)
                .disabled(viewModel.isLoading)
             
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                    case .success(let auth):
                        if let cred = auth.credential as? ASAuthorizationAppleIDCredential {
                            viewModel.handleAppleLogin(cred: cred)
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                .signInWithAppleButtonStyle(.black)
                .disabled(viewModel.isLoading)
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.showUserForm) {
                UserFormView(credential: viewModel.pendingCredential)
            }
        }
    }
}

#Preview {
    LandingView()
}
