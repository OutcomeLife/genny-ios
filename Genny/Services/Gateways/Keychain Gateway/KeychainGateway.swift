//
//  KeychainGateway.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//
//

import Foundation
import SwiftKeychainWrapper

final class KeychainGateway {
    
    fileprivate static let authTokenKey = "com.genny.auth.token"
    
    static let shared = KeychainGateway()
}

// MARK: - KeychainSavingProtocol
extension KeychainGateway: KeychainSavingProtocol {
    
    func save(token: String) {
        KeychainWrapper.standard.set(token, forKey: KeychainGateway.authTokenKey)
    }
    
    func getSavedToken() -> String? {
        return KeychainWrapper.standard.string(forKey: KeychainGateway.authTokenKey)
    }
    
    func deleteSavedToken() {
        KeychainWrapper.standard.set("", forKey: KeychainGateway.authTokenKey)
    }
}
