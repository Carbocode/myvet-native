//
//  Races.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//


struct Race: Identifiable, Hashable, Codable, Equatable {
    let idRazza: Int
    let nome: String
    let macroRazza: Bool
    let moltiplicatore: Double?
    
    var id: Int { idRazza }
}
