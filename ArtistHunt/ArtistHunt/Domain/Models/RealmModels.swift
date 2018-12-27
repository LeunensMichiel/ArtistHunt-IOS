//
//  RealmModels.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
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
