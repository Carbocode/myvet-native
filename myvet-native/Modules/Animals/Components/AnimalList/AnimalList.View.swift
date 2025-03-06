//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct AnimalListView: View {
    @ObservedObject var viewModel = AnimalListViewModel()
    @Binding var selectedAnimal: Animal?

    var body: some View {
        
            // Sidebar: Elenco degli animali
            List(viewModel.animals, selection: $selectedAnimal) { animal in
                NavigationLink(destination: AnimalView(viewModel: AnimalViewModel(animal: animal))) {
                    AnimalCardView(viewModel: AnimalCardViewModel(animal: animal))
                }
            }
            .navigationTitle("I miei animali")
            .listStyle(.plain)
    }
}
