//
//  AnimalCardViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

@Observable @MainActor
class AnimalProfileCardViewModel {
    final var animal: Animal  // Dati dell'animale
    
    // Inizializziamo il ViewModel con un animale
    init(animal: Animal) {
        self.animal = animal
    }
}
