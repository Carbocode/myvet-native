//
//  AnimalDetailsViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 28/06/25.
//

import Foundation

@Observable @MainActor
class AnimalDetailsViewModel{
    var animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
}
