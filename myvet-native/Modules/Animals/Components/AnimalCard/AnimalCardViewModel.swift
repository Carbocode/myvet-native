//
//  AnimalCardViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

// ViewModel: gestisce i dati per AnimalCardView
class AnimalCardViewModel: ObservableObject {
    @Published final var animal: Animal  // Dati dell'animale
    
    // Inizializziamo il ViewModel con un animale
    init(animal: Animal) {
        self.animal = animal
    }
}
