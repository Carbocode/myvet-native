//
//  SearchRequest.swift
//  myvet-native
//
//  Created by Ligmab Allz on 16/07/25.
//

struct SearchRequest: Encodable {
    var indexes: [String]
    var query: String?
    var idSpecializzazione: Int?
    var showMap: Bool
    var lat: Double?
    var lon: Double?
}
