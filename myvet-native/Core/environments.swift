//
//  environments.swift
//  myvet-native
//
//  Created by Ligmab Allz on 2024-10-03.
//

import Foundation

struct Config {
    static let baseURL = URL(string: "https://myvetbusiness.it/")  // URL base per le chiamate API
    static let imgURL = URL(string: "imgs/", relativeTo: baseURL)  // URL base per le chiamate API
    static let animalURL = URL(string: "animals/", relativeTo: imgURL)  // URL base per le chiamate API
}
