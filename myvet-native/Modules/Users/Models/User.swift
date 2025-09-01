//
//  User.swift
//  myvet-native
//
//  Created by Ligmab Allz on 27/06/25.
//

import Foundation

struct User: Identifiable, Hashable, Codable, Equatable {
    let idAccount: Int
    var idTipologia: Int
    var nome: String
    var cognome: String
    var email: String
    var password: String
    var telefono: String?
    var codiceFiscale: String?
    var immagine: String?
    
    var id: Int { idAccount }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id
    }
}

