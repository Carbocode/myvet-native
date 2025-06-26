//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct AnimalListView: View {
    @ObservedObject var viewModel = AnimalListViewModel()
    @State var selectedAnimal: Animal? = nil

    var body: some View {
        
            // Sidebar: Elenco degli animali
            List(viewModel.animals, id: \.id) { animal in
                NavigationLink(destination: AnimalView(animal: animal)) {
                    AnimalCardView(animal: animal)
                }
            }
            .navigationTitle("I miei animali")
            .listStyle(.plain)
    }
}

#Preview {
    AnimalListView(selectedAnimal: nil)
}
