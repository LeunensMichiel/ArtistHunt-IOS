//
//  RouterAPI.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import Alamofire

enum UserRouterApi: URLRequestConvertible {
    
    case login(email:String, password:String)
    case register(email:String, password: String, firstname: String, lastname: String)
    //    case posts
    //    case post(id: Int)
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
            //        case .posts, .post:
            //            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/API/users/login"
        case .register:
            return "/API/users/register"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password]
        case .register(let email, let password, let firstname, let lastname):
            return [K.APIParameterKey.email: email, K.APIParameterKey.password: password, K.APIParameterKey.firstname: firstname, K.APIParameterKey.lastname: lastname]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
