//
//  Vet.swift
//  myvet-native
//
//  Created by Ligmab Allz on 17/07/25.
//

import CoreLocation

struct Vet: Identifiable, Decodable, Equatable, Hashable {
    let idVeterinario: Int
    var idTipologia: Int?
    let nomeSpecializzazione: String?
    let nome: String
    let cognome: String?
    let email: String?
    var telefono: String?
    var codiceFiscale: String?
    var immagine: String = "default.png"
    var indirizzo: String?
    var posizione: Coordinate?
    var preferito: Bool = false
    var descrizione: String?
    var struttura: String?
    var idStruttura: Int?
        
    struct Coordinate: Decodable, Hashable {
        let lat: Double
        let lon: Double
    }
    
    var id: Int { idVeterinario }
    
    static func == (lhs: Vet, rhs: Vet) -> Bool {
        lhs.id == rhs.id
    }

    static let example = Vet(
        idVeterinario: 1,
        idTipologia: 101, nomeSpecializzazione: "Borseggiatore",
        nome: "Mario",
        cognome: "Rossi",
        email: "mario.rossi@email.com",
        telefono: "+391234567890",
        codiceFiscale: "RSSMRA80A01F205X",
        indirizzo: "Via Roma 1, Milano",
        posizione: Coordinate(lat: 45.4642, lon: 9.19),
        preferito: false
    )
}
