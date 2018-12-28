//
//  RealmModels.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @objc dynamic var _id: String? = ""
    @objc dynamic var firstname: String? = ""
    @objc dynamic var lastname: String? = ""
    @objc dynamic var email: String? = ""
    @objc dynamic var token: String? = ""
    @objc dynamic var profile_image_filename: String? = ""
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}

class RealmPost: Object {
    @objc dynamic var _id: String? = ""
    @objc dynamic var title: String? = ""
    @objc dynamic var postdescription: String? = ""
    @objc dynamic var type: String? = ""
    @objc dynamic var user_id: String? = ""
    @objc dynamic var post_image_filename: String? = ""
    @objc dynamic var post_audio_filename: String? = ""
    @objc dynamic var date: Date? = nil
    
    override static func primaryKey() -> String? {
        return "_id"
    }
}
