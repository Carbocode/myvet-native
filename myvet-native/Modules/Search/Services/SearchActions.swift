//
//  SearchActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 14/07/25.
//

import Foundation

class SearchActions {
    
    static func read(query: String?, idSpecializzazione: Int?, showMap: Bool, lat: Double?, lon: Double?, indexes: [String]) async throws -> [Vet] {
        
        let body = SearchRequest(indexes: indexes, query: query, idSpecializzazione: idSpecializzazione, showMap: showMap, lat: lat, lon: lon)
        
        
        let dtos: [VetQueryDTO] = try await Fetch.post(endpoint: "/vets/query/create", body: body, headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
        
        return dtos.map { $0.toVet() }
    }
}

private struct VetQueryDTO: Decodable {
    let idbusiness: Int
    let idtipologia: Int?
    let nomeSpecializzazione: String?
    let nome: String
    let cognome: String?
    let email: String?
    let telefono: String?
    let codiceFiscale: String?
    let immagine: String?
    let indirizzo: String?
    let posizione: Vet.Coordinate?
    let preferito: Bool?
    let descrizione: String?
    let struttura: String?
    let idStruttura: Int?

    func toVet() -> Vet {
        Vet(
            idVeterinario: idbusiness,
            idTipologia: idtipologia,
            nomeSpecializzazione: nomeSpecializzazione,
            nome: nome,
            cognome: cognome,
            email: email,
            telefono: telefono,
            codiceFiscale: codiceFiscale,
            immagine: immagine ?? "default.png",
            indirizzo: indirizzo,
            posizione: posizione,
            preferito: preferito ?? false,
            descrizione: descrizione,
            struttura: struttura,
            idStruttura: idStruttura
        )
    }
}

