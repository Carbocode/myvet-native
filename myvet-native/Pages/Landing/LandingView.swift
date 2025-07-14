//
//  LandingView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI
import AuthenticationServices

struct LandingView: View {
    @State private var showUserForm = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                NavigationLink("Login") {
                    LoginView()
                }
                .tint(.blue)
                .buttonStyle(.glass)

                NavigationLink("Registrazione") {
                    UserFormView()
                }
                .tint(.blue)
                .buttonStyle(.glass)
             
                SignInWithAppleButton(.signIn) { request in
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    switch result {
                        case .success(_):
                            showUserForm = true
                        case .failure(let error):
                            print("Authorization failed: \(error.localizedDescription)")
                    }
                }
                .signInWithAppleButtonStyle(.black)
            }
            .padding()
            .navigationDestination(isPresented: $showUserForm) {
                UserFormView()
            }
        }
    }
}

#Preview {
    LandingView()
}
