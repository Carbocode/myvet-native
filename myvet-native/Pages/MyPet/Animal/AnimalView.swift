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
                VStack {
                    HStack{
                        let fullURL = Config.animalURL.appendingPathComponent("/" + (viewModel.animal.immagine ?? "/default.png"))
                        AsyncImage(url: fullURL)
                        { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.horizontal, 20)
                        
                        Text(viewModel.animal.nome)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(1)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                }
                Picker("Seleziona una sezione", selection: $selectedSection) {
                                Text("Cartella Clinica").tag(0)
                                Text("Dettaglia").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())  // Imposta lo stile come segmentato
                            .padding(.horizontal, 20)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {  // Pulsante a destra
                    Button("Edit") { /* Add edit action here */ }
                }
            }
        }
            
    }
}

#Preview {
    let animal: Animal = .init(idAnimale: 1, nome: "Animalo", immagine: "default.png")
    
   AnimalView(animal: animal)
}
