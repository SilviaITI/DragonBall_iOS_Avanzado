//
//  KeyChainProvider.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Silvia Casanova Martinez on 14/1/24.
//

import Foundation
import KeychainSwift

protocol KeyChainProviderProtocol {
    func save(token: String)
    func getToken() -> String?
    func delete(token: String)
}
class KeyChainProvider: KeyChainProviderProtocol {
    private let keyChain = KeychainSwift()
    private enum Key {
        static let token = "KEY_KEYCHAIN_TOKEN"
    }
    func save(token: String) {
        keyChain.set(token, forKey: Key.token )
    }
    func getToken() -> String? {
        keyChain.get(Key.token)
    }
    func delete(token: String) {
        keyChain.delete(Key.token)
    }
}
