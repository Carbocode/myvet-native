//
//  Sizes.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//


struct Size: Identifiable, Hashable, Codable, Equatable {
    let idTaglia: Int
    let nome: String
    let mesiFineCucciolo: Int?
    
    var id: Int { idTaglia }
}
