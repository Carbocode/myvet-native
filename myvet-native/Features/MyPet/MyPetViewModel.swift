//
//  MyPetViewModel.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

class MyPetViewModel: ObservableObject {
    @Published var animals: [Animal] = []
    
    init() {
        // Simuliamo il caricamento di animali
        animals = [
            .init(id: 1, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 2, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 3, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 4, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 5, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 6, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 7, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 8, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 9, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png"),
            .init(id: 10, userId: 1, name: "Animalo", breedId: 1, birthDate: Date(), gender: "F", sizeId: 2, sterilized: true, insured: false, image: "default.png")
        ]
    }
}
