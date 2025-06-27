//
//  User.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

struct User: Identifiable, Hashable, Codable, Equatable {
    let idUtente: Int
    var nome: String
    var cognome: String
    var email: String
    var telefono: String?
    var codiceFiscale: String?
    
    var id: Int { idUtente }
}

