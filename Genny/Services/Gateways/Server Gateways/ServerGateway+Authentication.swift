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
    
    func login(username: String, password: String) -> Promise<String> {
        return Promise { fulfill, reject in
            let loginRequest = API.login(username, password)
            Alamofire.request(loginRequest).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let responseJSON = JSON(data)
                    let token = responseJSON["access_token"].stringValue
                    fulfill(token)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
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
