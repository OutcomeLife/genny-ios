//
//  AuthenticationServiceProtocol.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthenticationServiceProtocol {
    
    func logout() -> Promise<Bool>
}
