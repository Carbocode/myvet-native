//
//  NotificationActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 01/09/25.
//

import Foundation

#if os(iOS)
import UIKit
#endif

final class NotificationAction {
    
    static func create(tokenNotifiche: String) async throws -> EmptyResponse {
        let device = NotificationDeviceRequest(
            Identificativo: DeviceDetails.deviceIdentifier,
            SistemaOperativo: DeviceDetails.systemNameAndVersion,
            Modello: DeviceDetails.deviceModel,
            Nome: DeviceDetails.deviceName,
            TokenNotifiche: tokenNotifiche
        )
        return try await Fetch.post(
            endpoint: "/notifications/devices/create",
            body: device,
            headers: ["Authorization": AuthManager.shared.getToken() ?? ""]
        )
    }
}

/// Helper for cross-platform device info
private enum DeviceDetails {
    
    /// Unique identifier for device (not user-privacy-invading, but persistent for the app vendor)
    static var deviceIdentifier: String {
#if os(iOS)
        return UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
#elseif os(macOS)
        // Use hardware UUID, or fallback to computer name
        if let uuid = Host.current().localizedName {
            return uuid
        }
        return "macOS-unknown"
#else
        return "unknown-device"
#endif
    }
    
    /// Human-readable OS name and version (e.g., "iOS 17.5.1" or "macOS 14.4")
    static var systemNameAndVersion: String {
#if os(iOS)
        let device = UIDevice.current
        return "\(device.systemName) \(device.systemVersion)"
#elseif os(macOS)
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "macOS \(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
#else
        return "unknown-OS"
#endif
    }
    
    /// Device model (e.g., "iPhone", "iPad", "MacBookPro")
    static var deviceModel: String {
#if os(iOS)
        return UIDevice.current.model
#elseif os(macOS)
        // Could use sysctl for detailed info; fallback to "Mac"
        return "Mac"
#else
        return "unknown-model"
#endif
    }
    
    /// Device name (user-configurable, e.g., "Luca’s iPhone")
    static var deviceName: String? {
#if os(iOS)
        return UIDevice.current.name
#elseif os(macOS)
        return Host.current().localizedName
#else
        return nil
#endif
    }
}
