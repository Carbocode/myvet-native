//
//  AnimalCarouselViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import Foundation

@Observable @MainActor
class AnimalCarouselViewModel {
    var animals: [Animal] = []
    
    init() {
        Task {
            await loadAnimals()
        }
    }
    
    func loadAnimals() async {
        do {
            animals = try await AnimalsActions.readAll()
        } catch {
            // handle error if needed
        }
    }
}
