//
//  SwiftUIView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-04.
//

import SwiftUI

struct AnimalView: View {
    @ObservedObject var viewModel: AnimalViewModel
    @State private var selectedSection = 0
    
    init(animal: Animal) {
        self.viewModel = AnimalViewModel(animal: animal)
    }
    
    var body: some View {
        
        NavigationStack{
            ScrollView {
                let fullURL = Config.animalURL.appendingPathComponent("/" + (viewModel.animal.immagine ?? "/default.png"))
                
                VStack {
                    ProfilePictureView(url: fullURL, name: viewModel.animal.nome)
                    
                    if selectedSection == 0 {
                        // Contenuto "Cartella Clinica": lista di visite veterinarie fittizie
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Ultime visite")
                                .font(.headline)
                                .padding(.top, 20)
                            ForEach(0..<3) { i in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Visita del \(["10/01/2024", "05/07/2023", "12/12/2022"][i])")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Text("Motivo: Controllo annuale. Veterinario: Dr. Rossi")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                                .background(Color.accentColor.opacity(0.07))
                                .cornerRadius(10)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    } else {
                        // Contenuto "Profilo": informazioni dettagliate da viewModel.animal
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Profilo animale")
                                .font(.headline)
                                .padding(.top, 20)
                            Text("Nome: \(viewModel.animal.nome)")
                            if let nomeSpecie = viewModel.animal.nomeSpecie {
                                Text("Specie: \(nomeSpecie)")
                            }
                            if let nomeRazza = viewModel.animal.nomeRazza {
                                Text("Razza: \(nomeRazza)")
                            }
                            if let dataNascita = viewModel.animal.dataNascita {
                                Text("Data di nascita: \(dataNascita)")
                            }
                            if let luogoNascita = viewModel.animal.luogoNascita {
                                Text("Luogo di nascita: \(luogoNascita)")
                            }
                            if let sesso = viewModel.animal.sesso {
                                Text("Sesso: \(sesso)")
                            }
                            if let nomeTaglia = viewModel.animal.nomeTaglia {
                                Text("Taglia: \(nomeTaglia)")
                            }
                            if let peso = viewModel.animal.peso {
                                Text("Peso: \(peso) kg")
                            }
                            if let microchip = viewModel.animal.microchip {
                                Text("Numero Microchip: \(microchip)")
                            }
                            if let passaporto = viewModel.animal.passaporto {
                                Text("Numero Passaporto: \(passaporto)")
                            }
                            if let mantello = viewModel.animal.mantello {
                                Text("Mantello: \(mantello)")
                            }
                            if let descrizione = viewModel.animal.descrizione {
                                Text("Descrizione: \(descrizione)")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {  // Pulsante a destra
                Button("Edit") { /* Add edit action here */ }
            }
            ToolbarItem(placement: .principal) {
                Picker("Seleziona una sezione", selection: $selectedSection) {
                    Text("Cartella Clinica").tag(0)
                    Text("Profilo").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .labelsHidden()
            }
        }
    }
    
}


#Preview {
    let animal: Animal = .init(idAnimale: 1, nome: "Animalo", immagine: "default.png")
    
   AnimalView(animal: animal)
}

