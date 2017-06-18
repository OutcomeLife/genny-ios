//
//  AuthenticationServiceProtocol.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import PromiseKit

protocol AuthenticationServiceProtocol {
    
    func login(username: String, password: String) -> Promise<Bool>
    
    func logout() -> Promise<Bool>
}
