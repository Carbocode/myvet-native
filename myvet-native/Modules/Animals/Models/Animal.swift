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
    var sterilizzato: Bool?
    var assicurato: Bool?
    var immagine: String?
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
}
