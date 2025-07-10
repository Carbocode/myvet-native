//
//  AnimalCreateRequest.swift
//  myvet-native
//
//  Created by Ligmab Allz on 04/07/25.
//

struct AnimalCreateRequest: Encodable {
    var Nome: String
    var Microchip: String?
    var Passaporto: String?
    var DataNascita: String?
    var LuogoNascita: String?
    var Sesso: String
    var IDTaglia: Int?
    var IDAttivita: Int?
    var IDCorporatura: Int?
    var Peso: Double?
    var Sterilizzato: Bool
    var Assicurato: Bool?
    var IDRazza: Int
    var Mantello: String?
    var Descrizione: String?
    var Immagine: String?
    var Estensione: String?
}
