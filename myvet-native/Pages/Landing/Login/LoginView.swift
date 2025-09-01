//
//  LoginView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-05.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        
#if os(iOS)
        Form {
            
            TextField("Email", text: $viewModel.loginRequest.Email)
                .padding()
                .glassEffect()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.bottom, 10)
            
            
            SecureField("Password", text: $viewModel.loginRequest.Password)
                .padding()
                .glassEffect()
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
                .tint(.blue)
                .buttonStyle(.glass)
                .disabled(viewModel.isLoading)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
                
            }
            
        }
        .navigationTitle("Login")
        .frame(maxHeight: .infinity, alignment: .top)
        .frame(maxWidth: 400)
        .padding()
#elseif os(macOS)
        Form {
            Section(header:
                        Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
            ){
                
                TextField("Email", text: $viewModel.loginRequest.Email)
                
                
                SecureField("Password", text: $viewModel.loginRequest.Password)
                
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
                .tint(.blue)
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            
        }
        .padding()
#endif
        
    }
}


#Preview {
    LoginView()
}

