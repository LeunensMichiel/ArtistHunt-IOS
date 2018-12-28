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
    case posts
    
    private var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .posts:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .login:
            return "/API/users/login"
        case .register:
            return "/API/users/register"
        case .posts:
            return "/API/post/post"
        }
    }
    
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [Constants.APIParameterKey.email: email, Constants.APIParameterKey.password: password]
        case .register(let email, let password, let firstname, let lastname):
            return [Constants.APIParameterKey.email: email, Constants.APIParameterKey.password: password, Constants.APIParameterKey.firstname: firstname, Constants.APIParameterKey.lastname: lastname]
        case .posts:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue("Bearer " + AuthenticationController.getToken()!, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        // Parameters
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}
