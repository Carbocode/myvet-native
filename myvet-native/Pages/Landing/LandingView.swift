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
            ZStack{
                LinearGradient(
                    gradient:
                        Gradient(colors: [
                        Color(red: 63/255, green: 179/255, blue: 218/255),
                        Color(red: 58/255, green: 108/255, blue: 172/255)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    backgroundImage
                        .frame(height: 500)
                    Spacer()
                    buttons
                }
                
                VStack{
                    Text("Benvenuto su MyVet!")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
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
                        Text("Benvenuto su MyVet!")
                            .font(.largeTitle.bold())
                            .multilineTextAlignment(.center)
                            .padding(.top, 8)
                            .foregroundColor(.white)
                        buttons
                    }
                }
            }
        }
        #endif
    }
    
    var buttons: some View{
        VStack(spacing: 24) {
            
            HStack{
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
            }
            
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
            .frame(width: 250, height: 45)
            .cornerRadius(12)
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
