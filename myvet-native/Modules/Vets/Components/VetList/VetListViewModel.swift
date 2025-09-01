//
//  VetListViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 30/08/25.
//

import Foundation

@Observable @MainActor
class VetListViewModel {
    var favoriteVets: [Vet] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    func read() async {
        isLoading = true
        errorMessage = nil
        do {
            let results = try await VetsActions.readFavorites()
            self.favoriteVets = results
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
