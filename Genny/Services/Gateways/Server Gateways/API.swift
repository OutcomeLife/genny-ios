//
//  API.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//
//

import Foundation
import Alamofire

enum API {
    
    static let baseURLString = "https://bouncer.outcome-hub.com"
    
    case login(String, String)
    case logout(String)
}

// MARK: - HTTPMethod
extension API {
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout:
            return .post
        }
    }
}

// MARK: - Endpoint
extension API {
    
    var endpoint: String {
        switch self {
        case .login:
            return "/auth/realms/channel40/protocol/openid-connect/token"
        case .logout:
            return "/auth/realms/channel40/protocol/openid-connect/logout"
        }
    }
}

// MARK: - URLRequestConvertible
extension API: URLRequestConvertible {
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any]? = {
            switch self {
            case .login(let username, let password):
                return ["username": username,
                        "password": password,
                        "grant_type": "password",
                        "client_id": "ios",
                        "client_secret": "9662fa26-dd6b-4efb-a25d-3a2d690e352a"]
            case .logout(let token):
                return ["refresh_token": token, "client_id": "ios"]
            }
        }()
        
        guard let baseURL = URL(string: API.baseURLString) else {
            let blankURL = URL(fileURLWithPath: "")
            return URLRequest(url: blankURL)
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(self.endpoint))
        request.httpMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let encodedRequest = try URLEncoding.default.encode(request, with: parameters)
        
        return encodedRequest
    }
}
