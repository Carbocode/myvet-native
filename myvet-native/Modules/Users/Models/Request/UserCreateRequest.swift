//
//  AnimalCreateRequest.swift
//  myvet-native
//
//  Created by Ligmab Allz on 04/07/25.
//

struct UserCreateRequest: Encodable {
    var Nome: String
    var Cognome: String
    var Email: String
    var Password: String
    var CodiceFiscale: String
    var Telefono: String
    var Tipo: String
    var Newsletter: Bool
    var TOS: Bool
    var CondizioniGenerali: Bool
    var Immagine: String?
    var Estensione: String?
}
