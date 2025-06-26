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
                .padding(.bottom, 20)
            
            HStack {
#if os(macOS)
                Text("Email")
                    .font(.headline)
                    .frame(width: 80, alignment: .trailing)
#endif
                TextField("Email", text: $viewModel.loginRequest.Email)
#if os(iOS)
                    .padding()
                    .glassEffect()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
#endif
            }
            .padding(.bottom, 10)
            

            HStack {
#if os(macOS)
                Text("Password")
                    .font(.headline)
                    .frame(width: 80, alignment: .trailing)
#endif
                SecureField("Password", text: $viewModel.loginRequest.Password)
#if os(iOS)
                    .padding()
                    .glassEffect()
#endif
            }
            .padding(.bottom, 20)

            HStack {
                Spacer()
                Button(action: {
                    viewModel.handleLogin()
                }) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Login")
                                .font(.headline)
                        }
                    }
                }
#if os(iOS)
                .buttonStyle(.borderedProminent)
#elseif os(macOS)
                .buttonStyle(.bordered)
#endif
                .tint(.blue)
                .controlSize(.extraLarge)
                .disabled(viewModel.isLoading)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
                .buttonStyle(.glass)
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: 400)
        .padding()
    }
}


#Preview {
    LoginView()
}
