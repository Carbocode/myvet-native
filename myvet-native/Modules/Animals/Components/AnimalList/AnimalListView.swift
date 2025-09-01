//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct AnimalListView: View {
    @State var viewModel = AnimalListViewModel()

    var body: some View {
        List {
            if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                ForEach(viewModel.animals, id: \.id) { animal in
                    NavigationLink(destination: AnimalView(animal: animal)){
                        AnimalProfileCardView(animal: animal)
                    }
                }
            }
        }
        .onAppear {
            Task { await viewModel.read() }
        }
    }
}

#Preview {
    // La lista, poter essere interagibile, deve almeno essere dentro una NavigationStack. Di base lo è già alla base della navigazione, ma per far funzionare la preview lo mettiamo anche qui
    NavigationStack{
        AnimalListView()
    }
}
