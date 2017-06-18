//
//  ServerGateway+Authentication.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import SwiftyJSON
import Alamofire
import PromiseKit

extension ServerGateway: ServerAuthenticationProtocol {
    
    func logout(token: String) -> Promise<Bool> {
        return Promise { fulfill, reject in
            let logoutRequest = API.logout(token)
            Alamofire.request(logoutRequest).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let responseJSON = JSON(data)
                    fulfill(true)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
