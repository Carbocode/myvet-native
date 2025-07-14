//
//  AnimalFormView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import SwiftUI
import PhotosUI

struct UserFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = UserFormViewModel()
    
    @State private var isSaving = false
    @State private var showSaveError = false
    @State private var saveErrorMessage = ""
    
    var inner: some View {
        Form {
            Section{
                ProfilePicturePicker(selectedImage: $viewModel.selectedImage)
#if os(iOS)
                    .frame(maxWidth: .infinity, alignment: .center)
#endif
            }
            .listRowBackground(Color.clear)
            
            Section(header: Text("Anagrafica")) {
                
                TextField("Nome", text: $viewModel.nome)
                    .textContentType(.givenName)
#if os(iOS)
                    .autocapitalization(.words)
#endif
                TextField("Cognome", text: $viewModel.cognome)
                    .textContentType(.familyName)
#if os(iOS)
                    .autocapitalization(.words)
#endif
                
                TextField("Codice Fiscale", text: $viewModel.codiceFiscale)
#if os(iOS)
                    .autocapitalization(.allCharacters)
#endif
            }
            .padding(2)
            
            Section(header: Text("Profilo")) {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                
                SecureField("Password", text: $viewModel.password)
                    .textContentType(.newPassword)
                
                TextField("Telefono", text: $viewModel.telefono)
                    .textContentType(.telephoneNumber)
#if os(iOS)
                    .autocapitalization(.allCharacters)
#endif
            }
            .padding(2)
            
            Toggle("Condizioni Generali", isOn: $viewModel.condizioniGenerali)
            Toggle("TOS", isOn: $viewModel.tos)
            Toggle("Newsletter", isOn: $viewModel.newsletter)
            
#if os(macOS)
            Button("Cancella", role: .cancel) {
                dismiss()
            }
            Button("Salva", role: .confirm) {
                isSaving = true
                viewModel.createUser { result in
                    isSaving = false
                    switch result {
                    case .success:
                        dismiss()
                    case .failure(let error):
                        saveErrorMessage = error.localizedDescription
                        showSaveError = true
                    }
                }
            }
            .tint(.blue)
            .buttonStyle(.borderedProminent)
            .disabled(isSaving)
#endif
        }
#if os(macOS)
        .padding()
#endif
    }
    
    var body: some View {
        VStack{
#if os(macOS)
            ScrollView{
                inner
            }
#else
            inner
#endif
        }
        .navigationTitle("Registrazione")
        .toolbar {
#if os(iOS)
            ToolbarItem(placement: .cancellationAction) {
                Button(role: .cancel) {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    isSaving = true
                    viewModel.createUser { result in
                        isSaving = false
                        switch result {
                        case .success:
                            dismiss()
                        case .failure(let error):
                            saveErrorMessage = error.localizedDescription
                            showSaveError = true
                        }
                    }
                } label: {
                    if isSaving {
                        ProgressView()
                    } else {
                        Image(systemName: "checkmark")
                    }
                }
                .disabled(isSaving)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
            }
#endif
        }
        .alert("Errore salvataggio", isPresented: $showSaveError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(saveErrorMessage)
        }
    }
}
    

#Preview {
    NavigationStack {
        UserFormView(viewModel: .init())
    }
}

