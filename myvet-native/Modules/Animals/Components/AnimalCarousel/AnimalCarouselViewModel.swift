//
//  AnimalCarouselViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/07/25.
//

import Foundation

class AnimalCarouselViewModel: ObservableObject {
    @Published var animals: [Animal] = []
    
    init() {
        AnimalsActions.readAll() { result in
            switch result {
                case .success(let result):
                self.animals = result
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}
