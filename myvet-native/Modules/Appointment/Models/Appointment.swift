//
//  Appointment.swift
//  myvet-native
//
//  Created by Ligmab Allz on 31/08/25.
//

import Foundation

struct Appointment: Identifiable, Hashable, Codable {
    var idAppuntamento: Int
    var idServizio: Int?
    var idAnimale: Int?
    var dataOraAppuntamento: Date
    var durata: Int
    var note: String
    
    var id: Int { idAppuntamento }
    
    static let example = Appointment(idAppuntamento: 1, idServizio: 1, idAnimale: 1, dataOraAppuntamento: .init(), durata: 30, note: "Ciaone")

}
