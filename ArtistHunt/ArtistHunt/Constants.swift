//
//  Constants.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3001"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let firstname = "firstname"
        static let lastname = "lastname"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
