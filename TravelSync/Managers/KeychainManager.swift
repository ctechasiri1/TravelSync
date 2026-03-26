//
//  KeychainManager.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/23/26.
//

import Foundation

final class KeychainManager {
    static let shared = KeychainManager()
    
    // unique identifier for your app's keychain items
    private let service = "com.travelsync.token"
    private let account = "authToken"
    
    private init() { }
    
    func saveToken(_ token: String) {
        let tokenData = Data(token.utf8)
        
        // create the query dictionary
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: tokenData
        ]
        
        // delete any existing token first to avoid dupication errors
        SecItemDelete(query as CFDictionary)
        
        // add the new token
        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            print("Failed to save token to Keychain: \(status)")
        }
    }
    
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
