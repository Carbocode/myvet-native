//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 06/03/25.
//

import SwiftUI

struct MyPetView: View {
    @State private var selectedAnimal: Animal?

    var body: some View {
        NavigationSplitView {
            AnimalListView(selectedAnimal: $selectedAnimal)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("MyPet")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {  // Pulsante a destra
                    Button(action: {
                        print("Azione premuta")
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
            // Detail: Dettagli dell'animale selezionato
            if let selectedAnimal = selectedAnimal {
                AnimalView(viewModel: AnimalViewModel(animal: selectedAnimal))
            } else {
                Text("Seleziona un animale")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    MyPetView()
}
