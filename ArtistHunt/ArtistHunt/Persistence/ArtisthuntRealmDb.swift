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
    func saveUser(user: User) {
        try! realm.write {
            realm.add(user)
        }
    }
    func updateUser(user: User) {
        try! realm.write {
            realm.add(user, update: true)
        }
    }
    func deleteUser(user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    public func findUserByID(by id: String) -> Results<User>
    {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realm.objects(User.self).filter(predicate)
    }

}
