//
//  AppointmentFormView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

import SwiftUI

struct AppointmentFormView: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: AppointmentFormViewModel
    @State private var isSaving = false
    @State private var showSaveError = false
    @State private var saveErrorMessage = ""
    @State private var selectedDate: Date  = .init()

    init(vet: Vet) {
        _viewModel = State(wrappedValue: AppointmentFormViewModel(vet: vet))
    }
    
    var inner: some View {
        Form {
            Section(header: Text("Dettagli")) {
                if viewModel.servizi.isEmpty {
                    ProgressView()
                } else {
                    Picker("Tipo di servizio", selection: $viewModel.idServizio) {
                        ForEach(viewModel.servizi, id: \.idServizio) { servizio in
                            Text(servizio.nome).tag(servizio.idServizio)
                        }
                    }
#if os(macOS)
                    .pickerStyle(.menu)
#elseif os(iOS)
                    .pickerStyle(.navigationLink)
#endif
                }
                
                if viewModel.animali.isEmpty {
                    ProgressView()
                } else {
                    Picker("Animale", selection: $viewModel.idAnimale) {
                        ForEach(viewModel.animali, id: \.idAnimale) { animale in
                            Text(animale.nome).tag(animale.idAnimale)
                        }
                    }
#if os(macOS)
                    .pickerStyle(.menu)
#elseif os(iOS)
                    .pickerStyle(.navigationLink)
#endif
                }
            }
            
            // Utilizza CalendarView con binding diretto sulla data/ora
            Section(header: Text("Data e ora")) {
                CalendarView(vet: viewModel.vet, selectedDateTime: $viewModel.dataOraAppuntamento)
            }
            
            Section(header: Text("Note")) {
                TextField("Note", text: $viewModel.note, axis: .vertical)
                    .frame(minHeight: 30)
            }
            
#if os(macOS)
            Button("Cancella", role: .cancel) {
                dismiss()
            }
            Button("Salva", role: .confirm) {
                Task {
                    isSaving = true
                    do {
                        try await viewModel.createAppointment()
                        isSaving = false
                        dismiss()
                    } catch {
                        isSaving = false
                        showSaveError = true
                        saveErrorMessage = error.localizedDescription
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
        VStack {
#if os(macOS)
            ScrollView {
                inner
            }
#else
            inner
#endif
        }
        .navigationTitle("Nuovo appuntamento")
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
                    Task {
                        isSaving = true
                        do {
                            try await viewModel.createAppointment()
                            isSaving = false
                            dismiss()
                        } catch {
                            isSaving = false
                            showSaveError = true
                            saveErrorMessage = error.localizedDescription
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
        AppointmentFormView(vet: Vet.example)
    }
}
