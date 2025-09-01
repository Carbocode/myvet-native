//
//  MyVetViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 18/07/25.
//

import Foundation

@Observable @MainActor
class VetViewModel {
    var vet: Vet
    var isLoading = false

    init(vet: Vet) {
        self.vet = vet
    }
    
    func toggleFavorite() async {
        isLoading = true
        do {
            let request = FavoriteRequest(IDVeterinario: vet.idVeterinario)
            try await VetsActions.updateFavorite(request: request)
            vet.preferito.toggle()
        } catch {
            print("Errore nel toggle preferito: \(error)")
        }
        isLoading = false
    }
}

