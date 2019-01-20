//
//  UserViewModel.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class PostViewModel {
    private let disposeBag = DisposeBag()
    private let localDB = ArtisthuntRealmDb()
    
    lazy var posts: Results<RealmPost> = {
        localDB.getAllPosts()
    }()
    
    lazy var userposts: Results<RealmPost> = {
        localDB.findPostsByUser(by: AuthenticationController.getUserId()!)
    }()
    
    func getPosts() {
        RouterClient.getPosts()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                result.forEach({ post in
                    if (self.localDB.findPostByID(by: post._id!).isEmpty) {
                        let realmpost = self.localDB.createDbPost(_id: post._id!, title: post.title!, postdescription: post.description!, type: post.type!, user_id: post.user_id!, post_image_filename: post.post_image_filename, post_audio_filename: post.post_audio_filename, date: post.date!)
                        self.localDB.savePost(post: realmpost)
                    }
                })
                self.posts = self.localDB.getAllPosts()
            }, onError: { error in
                switch error {
                case APIErrorConstants.unAuthorized:
                    print("401 error")
                case APIErrorConstants.notFound:
                    print("404 error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addPost(title: String, description: String, type: String, user_id: String, date: String) {
        RouterClient.addPost(title: title, description: description, type: type, user_id: user_id, date: date)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { result in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let realmpost = self.localDB.createDbPost(_id: result._id!, title: result.title!, postdescription: result.description!, type: result.type!, user_id: result.user_id!, post_image_filename: result.post_image_filename, post_audio_filename: result.post_audio_filename, date: result.date!)
                    self.localDB.savePost(post: realmpost)
            }, onError: { error in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                switch error {
                case APIErrorConstants.unAuthorized:
                    print("401 error")
                case APIErrorConstants.notFound:
                    print("404 error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func addImagePost(title: String, description: String, type: String, user_id: String, date: String, image: Data) {
        RouterClient.addImagePost(title: title, description: description, type: type, user_id: user_id, date: date, image: image)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { result in
                    print(result)
                    let realmpost = self.localDB.createDbPost(_id: result._id!, title: result.title!, postdescription: result.description!, type: result.type!, user_id: result.user_id!, post_image_filename: result.post_image_filename, post_audio_filename: result.post_audio_filename, date: result.date!)
                    self.localDB.savePost(post: realmpost)
            }, onError: { error in
                switch error {
                case APIErrorConstants.unAuthorized:
                    print("401 error")
                case APIErrorConstants.notFound:
                    print("404 error")
                default:
                    print("Unknown error:", error)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
