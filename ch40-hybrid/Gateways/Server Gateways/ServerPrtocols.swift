//
//  ServerPrtocols.swift
//  ch40-hybrid
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import PromiseKit

protocol ServerAuthenticationProtocol {
    
    func login(username: String, password: String) -> Promise<String>
    
    func logout(token: String) -> Promise<Bool>
}
