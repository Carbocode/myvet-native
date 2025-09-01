//
//  UserVIew.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI

struct UserView: View {
    @State var viewModel: UserViewModel = .init()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                form
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    AuthManager.shared.removeToken()
                } label: {
                    Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
        }
    }
    
    var form: some View {
        let imageName = viewModel.user?.immagine ?? "default.png"
        let fullURL = Config.userURL.appendingPathComponent("/" + imageName)
        let defaultURL = Config.userURL.appendingPathComponent("/default.png")
        
        return VStack {
            ProfilePictureView(url: fullURL, defaultUrl: defaultURL, name: viewModel.user?.nome ?? "")
                ListRowView(title: "Nome", value: viewModel.user?.nome ?? "-")
                ListRowView(title: "Cognome", value: viewModel.user?.cognome ?? "-")
                ListRowView(title: "Email", value: viewModel.user?.email ?? "-")
                ListRowView(title: "Telefono", value: viewModel.user?.telefono ?? "-")
                ListRowView(title: "Codice Fiscale", value: viewModel.user?.codiceFiscale ?? "-")
        }
        .ignoresSafeArea(edges: .top)
    }
}


#Preview {
    UserView()
}

