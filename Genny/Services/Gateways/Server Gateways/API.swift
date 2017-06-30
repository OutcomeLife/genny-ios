//
//  API.swift
//  Genny
//
//  Created by Garri Adrian Nablo on 6/15/17.
//  Copyright © 2017 OutcomeLife. All rights reserved.
//

import Foundation
import Alamofire

enum API {
    
    static let baseURLString = "https://bouncer.outcome-hub.com"
    
    case logout(String)
}

// MARK: - HTTPMethod
extension API {
    
    var method: HTTPMethod {
        switch self {
        case .logout:
            return .post
        }
    }
}

// MARK: - Endpoint
extension API {
    
    var endpoint: String {
        switch self {
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
