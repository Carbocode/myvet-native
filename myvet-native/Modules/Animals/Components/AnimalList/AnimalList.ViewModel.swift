//
//  MyPetViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

class AnimalListViewModel: ObservableObject {
    @Published var animals: [Animal] = []
    
    init() {
        AnimalsActions.animals() { result in
            switch result {
                case .success(let result):
                self.animals = result
                case .failure(let error):
                    print(error)
            }
            
        }
    }
}
