//
//  VetProfileCardViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 30/08/25.
//

import Foundation

@Observable @MainActor
class VetProfileCardViewModel {
    final var vet: Vet  // Dati dell'animale
    
    // Inizializziamo il ViewModel con un animale
    init(vet: Vet) {
        self.vet = vet
    }
}
