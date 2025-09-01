//
//  UserVIew.swift
//  myvet-native
//
//  Created by Ligmab Allz on 10/07/25.
//

import SwiftUI

struct UserView: View {
    @State var viewModel: UserViewModel = .init()
    @AppStorage("appearanceMode") private var appearanceRawValue: String = AppearanceMode.system.rawValue

    var appearance: AppearanceMode {
        AppearanceMode(rawValue: appearanceRawValue) ?? .system
    }

    var body: some View {
        let imageName = viewModel.user?.immagine ?? "default.png"
        let fullURL = Config.userURL.appendingPathComponent("/" + imageName)
        let defaultURL = Config.userURL.appendingPathComponent("/default.png")

        ScrollView{
            ProfilePictureView(url: fullURL, defaultUrl: defaultURL, name: viewModel.user?.nome ?? "")
            
            Picker("Modalità", selection: $appearanceRawValue) {
                ForEach(AppearanceMode.allCases) { mode in
                    Text(mode.rawValue).tag(mode.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top, 10)
            
            form
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
        .ignoresSafeArea(edges: .top)
    }
    
    var form: some View {
        VStack {
            InlineListView{
                InlineListRow{
                    ListRowView(title: "Nome", value: viewModel.user?.nome ?? "-")
                }
                InlineListRow{
                    ListRowView(title: "Cognome", value: viewModel.user?.cognome ?? "-")
                }
                InlineListRow{
                    ListRowView(title: "Email", value: viewModel.user?.email ?? "-")
                }
                InlineListRow{
                    ListRowView(title: "Telefono", value: viewModel.user?.telefono ?? "-")
                }
                InlineListRow{
                    ListRowView(title: "Codice Fiscale", value: viewModel.user?.codiceFiscale ?? "-")
                }
            }
            .padding()
        }
    }
}

#Preview {
    UserView()
}
