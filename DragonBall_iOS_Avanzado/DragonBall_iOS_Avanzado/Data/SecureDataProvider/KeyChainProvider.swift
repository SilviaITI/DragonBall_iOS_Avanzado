//
//  KeyChainProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 20/10/23.
//

import Foundation
import KeychainSwift

// Mark: - Protocol
protocol KeyChainProviderProtocol {
    func save(token: String)
    func getToken() -> String?
}

// Mark: - Class
final class KeyChainProvider: KeyChainProviderProtocol {
  
    
    // Mark: - Enum
    private enum Key {
        static let token = "KEY_KEYCHAIN_TOKEN"
    }
    
    // Mark: - Properties
    private let keyChain = KeychainSwift()
    
    // Mark: - Functions
    func save(token: String) {
        keyChain.set(token, forKey: Key.token)
    }
    
    func getToken() -> String? {
        keyChain.get(Key.token)
    }
    
}
