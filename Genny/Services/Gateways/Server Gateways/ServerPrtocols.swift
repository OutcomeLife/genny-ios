//
//  ServerPrtocols.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import PromiseKit

protocol ServerAuthenticationProtocol {
    
    func logout(token: String) -> Promise<Bool>
}
