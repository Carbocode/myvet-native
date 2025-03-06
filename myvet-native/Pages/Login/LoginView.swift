//
//  LoginView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            TextField("Email", text: $viewModel.loginRequest.Email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $viewModel.loginRequest.Password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 30)
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.bottom, 20)
            }
            
            Button(action: {
                viewModel.handleLogin()
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .disabled(viewModel.isLoading)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Login Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
                    }
                    .padding()
                }
            }

#Preview {
    LoginView()
}
