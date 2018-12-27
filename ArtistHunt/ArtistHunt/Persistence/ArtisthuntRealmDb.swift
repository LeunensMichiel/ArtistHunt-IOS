//
//  ArtisthuntRealmDb.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import RealmSwift

class ArtisthuntRealmDb {
    
    let realm: Realm = try! Realm()
    
    //USER
    func createDbUser(_id: String, email: String, firstname: String, lastname: String, token: String, profileImage: String?) -> RealmUser {
        let dbUser = RealmUser()
        dbUser._id = _id
        dbUser.email = email
        dbUser.firstname = firstname
        dbUser.lastname = lastname
        dbUser.token = token
        dbUser.profile_image_filename = profileImage
        return dbUser
    }

    
    func saveUser(user: RealmUser) {
        try! realm.write {
            realm.add(user)
        }
    }
    func updateUser(user: RealmUser) {
        try! realm.write {
            realm.add(user, update: true)
        }
    }
    func deleteUser(user: RealmUser) {
        try! realm.write {
            realm.delete(user)
        }
    }
    public func findUserByID(by id: String) -> Results<RealmUser>
    {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realm.objects(RealmUser.self).filter(predicate)
    }

}
