//
//  AnimalDetailsViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 28/06/25.
//

import Foundation

class AnimalDetailsViewModel: ObservableObject {
    @Published var animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
    }
}
