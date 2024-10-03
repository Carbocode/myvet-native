//
//  MyPetView.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-02.
//

import SwiftUI

struct MyPetView: View {
    var body: some View {
        
        @ObservedObject var viewModel = MyPetViewModel()
        
        NavigationView {
            ScrollView {
                VStack{
                    ForEach(viewModel.animals) { animal in
                        AnimalCardView(viewModel: AnimalCardViewModel(animal: animal))
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationTitle("I miei animali")  // Titolo nella barra di navigazione
            .navigationBarTitleDisplayMode(.large)
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
        }
    }
}

#Preview {
    MyPetView()
}
