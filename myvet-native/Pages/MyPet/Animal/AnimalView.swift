//
//  SwiftUIView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-04.
//

import SwiftUI

struct AnimalView: View {
    @State var viewModel: AnimalViewModel
    @State private var selectedSection = 0
    @State private var isEditing = false
    
    init(animal: Animal) {
        _viewModel = State(wrappedValue: AnimalViewModel(animal: animal))
    }
    
    var body: some View {
        NavigationStack{
            ScrollView{
                form
            }
        }
        .toolbar {
            #if os(iOS)
            ToolbarItem(placement: .automatic) {
                EditButton()
            }
            #elseif os(macOS)
            ToolbarItem(placement: .automatic) {
                Button(isEditing ? "Done" : "Edit") {
                    isEditing.toggle()
                }
            }
            #endif
            ToolbarItem(placement: .principal) {
                Picker("Seleziona una sezione", selection: $selectedSection) {
                    Text("Cartella Clinica").tag(0)
                    Text("Profilo").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .glassEffect()
                .labelsHidden()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    var form: some View {
        let imageName = viewModel.animal.immagine
        let fullURL = Config.animalURL.appendingPathComponent("/" + imageName)
        let defaultURL = Config.animalURL.appendingPathComponent("/default.png")
        
        return VStack {
            ProfilePictureView(url: fullURL, defaultUrl: defaultURL, name: viewModel.animal.nome)
            
            if selectedSection == 0 {
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
                AnimalDetailsView(animal: viewModel.animal)
            }
        }
    }
    
}


#Preview {    
    AnimalView(animal: Animal.example)
}

