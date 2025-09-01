//
//  AuthManager.swift
//  myvet-native
//
//  Created by Ligmab Allz on 03/03/25.
//

import Foundation
import Security

@Observable
class AuthManager {
    static let shared = AuthManager()
    
    var isAuthenticated: Bool = false
    
    private let jwtKey = "jwtToken"
    
    private init() {
        checkAuthentication()
    }
    
    func checkAuthentication() {
        isAuthenticated = getToken() != nil
    }
    
    func saveToken(_ token: String) {
        let data = Data(token.utf8)
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: jwtKey,
            kSecValueData: data
        ] as CFDictionary
        
        SecItemDelete(query)
        SecItemAdd(query, nil)
        isAuthenticated = true
    }
    
    func getToken() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: jwtKey,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary
        
        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query, &dataTypeRef) == noErr, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    func removeToken() {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: jwtKey
        ] as CFDictionary
        SecItemDelete(query)
        isAuthenticated = false
    }
}
