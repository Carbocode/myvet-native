//
//  Animal.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

// Modello per l'animale basato sulla struttura del database
struct Animal: Identifiable {
    var id: Int  // IDAnimale
    var userId: Int  // IDUtente
    var name: String  // Nome
    var breedId: Int  // IDRazza
    var birthDate: Date  // DataNascita
    var birthPlace: String?  // LuogoNascita (può essere NULL)
    var gender: Character  // Sesso (single character, 'M' o 'F')
    var sizeId: Int  // IDTaglia (default 2)
    var weight: Float?  // Peso (può essere NULL)
    var sterilized: Bool  // Sterilizzato
    var insured: Bool  // Assicurato
    var image: String  // Immagine (default "default.png")
    var microchip: String?  // Microchip (può essere NULL)
    var passport: String?  // Passaporto (può essere NULL)
    var coat: String?  // Mantello (può essere NULL)
    var description: String?  // Descrizione (può essere NULL)
}
