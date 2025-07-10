//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct AnimalListView: View {
    @StateObject var viewModel = AnimalListViewModel()

    var body: some View {
        // Sidebar: Elenco degli animali
        List(viewModel.animals, id: \.id) { animal in
            NavigationLink(destination: AnimalView(animal: animal)) {
                AnimalProfileCardView(animal: animal)
            }
        }
        .navigationTitle("I miei animali")
    }
}

#Preview {
    // La lista, poter essere interagibile, deve almeno essere dentro una NavigationStack. Di base lo è già alla base della navigazione, ma per far funzionare la preview lo mettiamo anche qui
    NavigationStack{
        AnimalListView()
    }
}
