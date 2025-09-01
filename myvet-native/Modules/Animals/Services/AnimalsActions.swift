//
//  MyPetActions.swift
//  myvet-native
//
//  Created by Ligmab Allz on 04/03/25.
//

import Foundation
import AVFoundation
import ImageIO
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

class AnimalsActions {
    static func readAll() async throws -> [Animal] {
        return try await Fetch.get(endpoint: "/animals/read-all", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
    
    static func read(id: Int) async throws -> Animal {
        return try await Fetch.get(endpoint: "/animals/read?id=\(id)", headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
    
    static func create(_ animal: AnimalCreateRequest, image: PlatformImage? = nil) async throws -> AnimalCreateResponse {
        var animal = animal
        
        if let img = image {
            if let (base64, ext) = convertImageToBase64AndExtension(image: img) {
                animal.Immagine = base64
                animal.Estensione = ext
            }
        }
        
        return try await Fetch.post(endpoint: "/animals/create", body: animal, headers: ["Authorization": AuthManager.shared.getToken() ?? ""])
    }
    
    private static func convertImageToBase64AndExtension(image: PlatformImage) -> (String, String)? {
#if os(iOS)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            return (jpegData.base64EncodedString(), "jpeg")
        }
        if let pngData = image.pngData() {
            return (pngData.base64EncodedString(), "png")
        }
        return nil
#elseif os(macOS)
        guard let tiffData = image.tiffRepresentation else {
            return nil
        }
        if let bitmap = NSBitmapImageRep(data: tiffData) {
            if let jpegData = bitmap.representation(using: .jpeg, properties: [:]) {
                return (jpegData.base64EncodedString(), "jpeg")
            }
            if let pngData = bitmap.representation(using: .png, properties: [:]) {
                return (pngData.base64EncodedString(), "png")
            }
        }
        return nil
#endif
    }
}

#if os(iOS) || os(tvOS) || os(watchOS)
private extension UIImage {
    // Helper method to get HEIC data on iOS/tvOS/watchOS if available
    func heicData(compressionQuality: CGFloat) -> Data? {
        if #available(iOS 11.0, tvOS 11.0, watchOS 4.0, *) {
            let imageData = NSMutableData()
            guard let destination = CGImageDestinationCreateWithData(imageData as CFMutableData, AVFileType.heic as CFString, 1, nil),
                  let cgImage = self.cgImage else { return nil }
            let options = [kCGImageDestinationLossyCompressionQuality as CFString: compressionQuality]
            CGImageDestinationAddImage(destination, cgImage, options as CFDictionary)
            if CGImageDestinationFinalize(destination) {
                return imageData as Data
            }
        }
        return nil
    }
}
#endif

