//
//  Animal.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

// Modello per l'animale basato sulla struttura del database
struct Animal: Identifiable, Hashable, Decodable {
    var idAnimale: Int
    var nome: String
    var dataNascita: String?
    var luogoNascita: String?
    var sesso: String?
    var idTaglia: Int?
    var nomeTaglia: String?
    var peso: Double?
    var immagine: String?
    var microchip: String?
    var passaporto: String?
    var idRazza: Int?
    var nomeRazza: String?
    var nomeSpecie: String?
    var mantello: String?
    var descrizione: String?
    
    var id: Int { idAnimale }
}
