//
//  UserVIew.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI

struct UserView: View {
    @StateObject var viewModel: UserViewModel = .init()
    
    
    var body: some View {
        
        NavigationStack{
            let imageName = viewModel.user?.immagine ?? "default.png"
            let fullURL = Config.userURL.appendingPathComponent(imageName)
                
            ScrollView{
                VStack {
                    ProfilePictureView(url: fullURL, name: viewModel.user?.nome ?? "")
                    Form {
                        ListRowView(title: "Nome", value: viewModel.user?.nome ?? "-")
                        ListRowView(title: "Cognome", value: viewModel.user?.cognome ?? "-")
                        ListRowView(title: "Email", value: viewModel.user?.email ?? "-")
                        ListRowView(title: "Telefono", value: viewModel.user?.telefono ?? "-")
                        ListRowView(title: "Codice Fiscale", value: viewModel.user?.codiceFiscale ?? "-")
                    }
                    .formStyle(.grouped)
                }
                .ignoresSafeArea(edges: .top)
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
    }
    
}


#Preview {
    UserView()
}
