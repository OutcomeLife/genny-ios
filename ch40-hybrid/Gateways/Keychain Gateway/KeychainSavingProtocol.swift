//
//  KeychainSavingProtocol.swift
//  ch40-hybrid
//
//  Created by Garri Adrian Nablo on 6/18/17.
//
//

import Foundation
import PromiseKit

protocol KeychainSavingProtocol {
    
    func getSavedToken() -> String?
    
    func save(token: String)
    
    func deleteSavedToken()
}
