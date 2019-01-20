//
//  Model.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation

struct Login: Codable {
    var email: String
    var password: String
}

struct Register: Codable {
    var email: String
    var password: String
    var firstname: String
    var lastname: String
}

struct User: Codable {
    var _id: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var token: String?
    var profile_image_filename: String?
}

struct Post: Codable {
    var _id: String?
    var title: String?
    var description: String?
    var type: String?
    var user_id: String?
    var post_image_filename: String?
    var post_audio_filename: String?
    var date: Date?
}

struct MessageUI {
    var message: String?
}

