//
//  AnimalFormView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import SwiftUI
import PhotosUI

struct AnimalFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = AnimalFormViewModel()
    
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
#if os(iOS)
                    .autocapitalization(.words)
#endif
                
                if viewModel.species.isEmpty {
                    ProgressView()
                } else {
                    Picker("Specie", selection: $viewModel.idSpecie) {
                        ForEach(viewModel.species, id: \.idSpecie) { specie in
                            Text(specie.nome).tag(specie.idSpecie)
                        }
                    }
#if os(macOS)
                    .pickerStyle(.menu)
#elseif os(iOS)
                    .pickerStyle(.navigationLink)
#endif
                }
                
                if viewModel.races.isEmpty {
                    ProgressView()
                } else {
                    Picker("Razza", selection: $viewModel.idRazza) {
                        ForEach(viewModel.races, id: \.idRazza) { specie in
                            Text(specie.nome).tag(specie.idRazza)
                        }
                    }
#if os(macOS)
                    .pickerStyle(.menu)
#elseif os(iOS)
                    .pickerStyle(.navigationLink)
#endif
                }
                
                DatePicker("Data di nascita", selection: $viewModel.dataNascita, displayedComponents: .date)
                
                TextField("Luogo di nascita", text: $viewModel.luogoNascita)
#if os(iOS)
                    .autocapitalization(.words)
#endif
                
                Picker("Sesso", selection: $viewModel.sesso) {
                    Text("Maschio").tag("M")
                    Text("Femmina").tag("F")
                }
                .pickerStyle(.segmented)
                
                Toggle("Sterilizzato", isOn: $viewModel.sterilizzato)
                
                if viewModel.sizes.isEmpty {
                    ProgressView()
                } else {
                    Picker("Taglia", selection: Binding(
                        get: { viewModel.idTaglia ?? 0 },
                        set: { viewModel.idTaglia = $0 == 0 ? nil : $0 }
                    )) {
                        ForEach(viewModel.sizes, id: \.idTaglia) { taglia in
                            Text(taglia.nome).tag(taglia.idTaglia)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                TextField("Peso (kg)", value: $viewModel.peso, format: .number)
#if os(iOS)
                    .keyboardType(.numbersAndPunctuation)
#endif
                
                if viewModel.bcs.isEmpty {
                    ProgressView()
                } else {
                    Picker("BCS", selection: Binding(
                        get: { viewModel.idCorporatura ?? 0 },
                        set: { viewModel.idCorporatura = $0 == 0 ? nil : $0 }
                    )) {
                        ForEach(viewModel.bcs, id: \.idCorporatura) { bcs in
                            Text(bcs.nome).tag(bcs.idCorporatura)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding(2)
            
            Section(header: Text("Info Sanitarie")) {
                TextField("Microchip", text: $viewModel.microchip)
#if os(iOS)
                    .autocapitalization(.allCharacters)
#endif
                
                TextField("Passaporto", text: $viewModel.passaporto)
#if os(iOS)
                    .autocapitalization(.allCharacters)
#endif
                Toggle("Assicurato", isOn: $viewModel.assicurato)
            }
            .padding(2)
            
            Section(header: Text("Aspetto e descrizione")) {
                TextField("Mantello", text: $viewModel.mantello)
#if os(iOS)
                    .keyboardType(.numbersAndPunctuation)
                    .autocapitalization(.none)
#endif
                TextField("Descrizione", text: $viewModel.descrizione, axis: .vertical)
                    .frame(minHeight: 30)
#if os(iOS)
                    .keyboardType(.numbersAndPunctuation)
                    .autocapitalization(.none)
#endif
                
                if viewModel.activityLevels.isEmpty {
                    ProgressView()
                } else {
                    Picker("Attività", selection: Binding(
                        get: { viewModel.idAttivita ?? 0 },
                        set: { viewModel.idAttivita = $0 == 0 ? nil : $0 }
                    )) {
                        ForEach(viewModel.activityLevels, id: \.idAttivita) { taglia in
                            Text(taglia.nome).tag(taglia.idAttivita)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding(2)
#if os(macOS)
            Button("Cancella", role: .cancel) {
                dismiss()
            }
            Button("Salva", role: .confirm) {
                isSaving = true
                viewModel.createAnimal { result in
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
        .navigationTitle("Nuovo animale")
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
                    viewModel.createAnimal { result in
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
        AnimalFormView(viewModel: .init())
    }
}
