//
//  KeychainService.swift
//  TravelSync
//
//  Created by Chiraphat Techasiri on 3/23/26.
//

import Foundation

final class KeychainService: Sendable {
    // THE ID: These two strings combine to make the unique identifier for the token
    private let service = "com.travelsync.token" /// 'folder'
    private let account = "authToken" /// 'file name'
    
    // MARK: Save Token
    func saveToken(_ token: String) {
        /// 1). conver the token string into UTF-8 bytes
        let tokenData = Data(token.utf8)
        
        /// 2). the dictionary is 'Instruction Manual' for what we want to hand to the framework
        let query: [String: Any] = [
            /// What type of thing are we saving? A generic password/secret
            kSecClass as String: kSecClassGenericPassword,
            /// The folder ID
            kSecAttrService as String: service,
            /// The file name ID
            kSecAttrAccount as String: account,
            /// The actual raw bytes of the token we want to lock away
            kSecValueData as String: tokenData
        ]
        
        /// 3).  delete any existing token first to avoid dupication errors
        SecItemDelete(query as CFDictionary)
        
        /// 4). add the new token once the slot is empty
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("Failed to save token to Keychain: \(status)")
        }
    }
    
    // MARK: Get Token
    func getToken() -> String? {
        /// 1). the dictionary is 'Instruction Manual' for what we want to hand to the framework
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            /// don't just check existsence, return the raw bytes as well
            kSecReturnData as String: true,
            /// provide the first instance that we see
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        /// 2). create an empty 'Pointer' in memory
        var dataTypeRef: AnyObject?
        
        /// 3). hands the valut our query, and give it the memory address to put the data in
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        /// 4). if the search and memory allocation was successful then cast that pointer into a Swift Data object
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            /// 5) convert the bytes back to a Swift String object
            return String(data: data, encoding: .utf8)
        }
        
        return nil
    }
    
    func deleteToken() {
        /// 1). the dictionary is 'Instruction Manual' for what we want to hand to the framework
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        /// 2).  delete any existing token
        SecItemDelete(query as CFDictionary)
    }
}
