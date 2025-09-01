//
//  MyPetViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

@Observable @MainActor
class AnimalListViewModel {
    
    var animals: [Animal] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    func read() async {
        isLoading = true
        errorMessage = nil
        do {
            let results = try await AnimalsActions.readAll()
            self.animals = results
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
