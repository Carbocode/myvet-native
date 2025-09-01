//
//  HTTPResponse.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/03/25.
//

import Foundation

struct HTTPResponse<T: Decodable>: Decodable {
    let mode: String
    let status: Int
    let description: String
    let body: T
    let log: [String]?
}
