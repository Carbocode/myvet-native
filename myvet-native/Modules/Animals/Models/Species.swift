//
//  Species.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

struct Species: Identifiable, Hashable, Codable, Equatable {
    let idSpecie: Int
    let nome: String
    
    var id: Int { idSpecie }
}
