//
//  Animal.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

// Modello per l'animale basato sulla struttura del database
struct Animal: Identifiable, Hashable, Codable, Equatable {
    var idAnimale: Int
    var nome: String
    var dataNascita: String?
    var luogoNascita: String?
    var sesso: String?
    var idTaglia: Int?
    var nomeTaglia: String?
    var peso: Double?
    var sterilizzato: Int?
    var assicurato: Int?
    var immagine: String = "default.png"
    var microchip: String?
    var passaporto: String?
    var idSpecie: Int?
    var idRazza: Int?
    var nomeSpecie: String?
    var nomeRazza: String?
    var idAttivita: Int?
    var idCorporatura: Int?
    var nomeAttivita: String?
    var nomeCorporatura: String?
    var mantello: String?
    var descrizione: String?
    
    var id: Int? { idAnimale }
    
    static let example = Animal(
        idAnimale: 1,
        nome: "Fido",
        dataNascita: "2020-01-01",
        luogoNascita: "Roma",
        sesso: "M",
        idTaglia: 2,
        nomeTaglia: "Media",
        peso: 14.5,
        sterilizzato: 1,
        assicurato: 0,
        microchip: "123456789012345",
        passaporto: "IT123456",
        idSpecie: 1,
        idRazza: 4,
        nomeSpecie: "Cane",
        nomeRazza: "Labrador",
        idAttivita: 1,
        idCorporatura: 3,
        nomeAttivita: "Compagnia",
        nomeCorporatura: "Robusta",
        mantello: "Marrone",
        descrizione: "Cane molto socievole e giocherellone."
    )
    
    static func == (lhs: Animal, rhs: Animal) -> Bool {
        lhs.id == rhs.id
    }
}
