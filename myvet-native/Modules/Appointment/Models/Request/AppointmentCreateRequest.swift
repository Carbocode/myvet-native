//
//  AppointmentCreateRequest.swift
//  myvet-native
//
//  Created by Ligmab Allz on 01/09/25.
//

import Foundation

struct AppointmentCreateRequest: Codable, Sendable {
    let IDVeterinario: Int
    let IDServizio: Int
    let IDAnimale: Int
    let DataAppuntamento: String
    let Note: String?
}
