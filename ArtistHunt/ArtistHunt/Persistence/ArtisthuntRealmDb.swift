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
    
    //POSTS
    func createDbPost(_id: String, title: String, postdescription: String, type: String, user_id: String, post_image_filename: String?, post_audio_filename: String?, date: Date) -> RealmPost {
        let dbPost = RealmPost()
        dbPost._id = _id
        dbPost.title = title
        dbPost.postdescription = postdescription
        dbPost.type = type
        dbPost.user_id = user_id
        dbPost.post_image_filename = post_image_filename
        dbPost.post_audio_filename = post_audio_filename
        dbPost.date = date
        return dbPost
    }
    
    func savePost(post: RealmPost) {
        try! realm.write {
            realm.add(post)
        }
    }
    func updatePost(post: RealmPost) {
        try! realm.write {
            realm.add(post, update: true)
        }
    }
    func deletePost(post: RealmPost) {
        try! realm.write {
            realm.delete(post)
        }
    }
    
    public func findPostByID(by id: String) -> Results<RealmPost>
    {
        let predicate = NSPredicate(format: "_id = %@", id)
        return realm.objects(RealmPost.self).filter(predicate)
    }
    
    public func findPostsByUser(by id: String) -> Results<RealmPost> {
        let predicate = NSPredicate(format: "user_id = %@", id)
        return realm.objects(RealmPost.self).filter(predicate)
    }
    
    public func getAllPosts() -> Results<RealmPost> {
        return realm.objects(RealmPost.self).sorted(byKeyPath: "date", ascending: false)
    }

}
