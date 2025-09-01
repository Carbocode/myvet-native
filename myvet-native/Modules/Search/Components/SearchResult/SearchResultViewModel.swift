//
//  SearchResultViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 17/07/25.
//

import Foundation

@Observable @MainActor
class SearchResultViewModel {
    final var vet: Vet  // Dati dell'animale
    
    // Inizializziamo il ViewModel con un animale
    init(vet: Vet) {
        self.vet = vet
    }
}
