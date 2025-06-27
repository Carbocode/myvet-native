//
//  Bcs.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//


struct Bcs: Identifiable, Hashable, Codable, Equatable {
    let idCorporatura: Int
    let nome: String
    let descrizione: String?
    let immagine: String?
    let moltiplicatore: Double?
    
    var id: Int { idCorporatura }
}
