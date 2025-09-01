//
//  NotificationDeviceRequest.swift
//  myvet-native
//
//  Created by Ligmab Allz on 01/09/25.
//

struct NotificationDeviceRequest: Codable, Sendable {
    var Identificativo: String
    var SistemaOperativo: String?
    var Modello: String?
    var Nome: String?
    var TokenNotifiche: String
}
