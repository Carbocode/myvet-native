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
    
    @State private var inspectorVisible: Bool = true

    var body: some View {
        #if os(iOS)
        NavigationStack {
            VStack{
                buttons
                backgroundImage
            }
        }
        #elseif os(macOS)
        NavigationStack {
            ZStack {
                backgroundImage
                VStack{
                    Rectangle().fill(Color.clear)
                }
                .inspector(isPresented: $inspectorVisible){
                    NavigationStack {
                        buttons
                    }
                }
            }
        }
        #endif
    }
    
    var buttons: some View{
        VStack(spacing: 24) {
            Text("Benvenuto su MyVet!")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            
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
            
            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $viewModel.showUserForm) {
            UserFormView(credential: viewModel.pendingCredential)
        }
    }
    
    var backgroundImage: some View {
        Image("DogRunning")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    LandingView()
}
