//
//  Constants.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3001"
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "email"
        static let firstname = "firstname"
        static let lastname = "lastname"
        
        //post
        static let _id = "id"
        static let title = "title"
        static let description = "description"
        static let type = "type"
        static let user_id = "user_id"
        static let post_image_filename = "post_image_filename"
        static let date = "date"

//        var _id: String?
//        var title: String?
//        var description: String?
//        var type: String?
//        var user_id: String?
//        var post_image_filename: String?
//        var post_audio_filename: String?
//        var date: Date?
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
