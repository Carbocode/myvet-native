//
//  MyVetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI
import MapKit
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

struct VetView: View {
    @State var viewModel: VetViewModel
    @State private var showAppointmentForm = false

    init(vet: Vet) {
        _viewModel = State(wrappedValue: VetViewModel(vet: vet))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                image
                actionButtons
                    .padding(.top, 16)
                form
            }
        }
        .onAppear(){
            Task {
                await viewModel.loadDetail()
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    Task {
                        await viewModel.toggleFavorite()
                    }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Image(systemName: viewModel.vet.preferito ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                    }
                }
                .help(viewModel.vet.preferito ? "Rimuovi dai preferiti" : "Aggiungi ai preferiti")
            }
        })
        .sheet(isPresented: $showAppointmentForm) {
            NavigationStack{
                AppointmentFormView(vet: viewModel.vet)
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    
    var image: some View {
        let imageName = viewModel.vet.immagine
        let fullURL = Config.vetURL.appendingPathComponent(imageName)
        let defaultURL = Config.vetURL.appendingPathComponent("default.png")
        
        return ProfilePictureView(url: fullURL, defaultUrl:defaultURL, name: viewModel.vet.nome)
    }

    var actionButtons: some View {
        HStack(spacing: 18) {
            // Chiama
            Button {
                if let telefono = viewModel.vet.telefono,
                   let url = URL(string: "tel:\(telefono.filter { !$0.isWhitespace })") {
#if os(iOS)
                    UIApplication.shared.open(url)
#elseif os(macOS)
                    NSWorkspace.shared.open(url)
#endif
                }
            } label: {
                Label("Chiama", systemImage: "phone.fill")
            }
            .tint(.green)
            .buttonStyle(.glass)
            .disabled(viewModel.vet.telefono?.isEmpty ?? true)

            // Email
            Button {
                if let email = viewModel.vet.email,
                   let url = URL(string: "mailto:\(email)") {
#if os(iOS)
                    UIApplication.shared.open(url)
#elseif os(macOS)
                    NSWorkspace.shared.open(url)
#endif
                }
            } label: {
                Label("Email", systemImage: "envelope.fill")
            }
            .tint(.green)
            .buttonStyle(.glass)
            .disabled(viewModel.vet.email?.isEmpty ?? true)
            
            // Appuntamento
            Button {
                showAppointmentForm = true
            } label: {
                Label("Richiedi appuntamento", systemImage: "calendar.badge.plus")
            }
            .tint(.blue)
            .buttonStyle(.glass)
        }
        .frame(maxWidth: .infinity)
    }

    var form: some View {
        InlineListView {
            InlineListRow{
                ListRowView(title: "Nome", value: viewModel.vet.nome)}
            InlineListRow{
                ListRowView(title: "Cognome", value: viewModel.vet.cognome ?? "-")}
            InlineListRow{
                ListRowView(title: "Email", value: viewModel.vet.email ?? "-")}
            InlineListRow{
                ListRowView(title: "Telefono", value: viewModel.vet.telefono ?? "-")}
            InlineListRow{
                ListRowView(title: "Codice Fiscale", value: viewModel.vet.codiceFiscale ?? "-")
            }
            InlineListRow{
                ListRowView(title: "Indirizzo", value: viewModel.vet.indirizzo ?? "-")}
            InlineListRow{
                ListRowView(title: "Descrizione", value: viewModel.vet.descrizione ?? "-")
            }
        }
        .padding()
    }
}

#Preview {
    VetView(vet: Vet.example)
}
