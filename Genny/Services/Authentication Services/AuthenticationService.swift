//
//  AuthenticationService.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import PromiseKit

final class AuthenticationService {
    
    fileprivate let serverGateway: ServerAuthenticationProtocol = ServerGateway.shared
    fileprivate let keychainGateway: KeychainSavingProtocol = KeychainGateway.shared
}

// MARK: - AuthenticationServiceProtocol
extension AuthenticationService: AuthenticationServiceProtocol {
    
    func logout() -> Promise<Bool> {
        guard let token = keychainGateway.getSavedToken() else { return Promise(value: false) }
        return serverGateway.logout(token: token)
    }
}
