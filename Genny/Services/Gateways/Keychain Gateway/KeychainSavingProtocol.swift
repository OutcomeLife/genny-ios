//
//  KeychainSavingProtocol.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/18/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import Foundation
import PromiseKit

protocol KeychainSavingProtocol {
    
    func getSavedToken() -> String?
    
    func save(token: String)
    
    func deleteSavedToken()
}
