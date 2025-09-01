//
//  Service.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

struct VetService: Identifiable, Hashable, Codable {
    var idServizio: Int
    var nome: String
    var durata: Int?
    
    var id: Int { idServizio }
}
