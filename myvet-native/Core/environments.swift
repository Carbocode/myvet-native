//
//  environments.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

struct Config {
    static let baseURL = URL(string: "https://dev.myvetbusiness.it")  // URL base per le chiamate API
    static let imgURL = baseURL!.appendingPathComponent("/imgs") // URL base per le chiamate API
    static let animalURL = imgURL.appendingPathComponent("/animals") // URL base per le chiamate API
    static let userURL = imgURL.appendingPathComponent("/users") // URL base per le chiamate API
    static let vetURL = imgURL.appendingPathComponent("/vets") // URL base per le chiamate API
    static let apiVersion = "/v1.0"
    static let apiURL = baseURL!.appendingPathComponent(apiVersion)  // URL base per le chiamate API
}
