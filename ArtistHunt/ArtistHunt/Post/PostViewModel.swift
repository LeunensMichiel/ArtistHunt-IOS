//
//  UserViewModel.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import RxSwift

class PostViewModel {
    private let disposeBag = DisposeBag()
    private let localDB = ArtisthuntRealmDb()
    
    func getPosts() {
        UserClient.getPosts()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { result in
                print(result)
                result.forEach({ post in
                    if (self.localDB.findPostByID(by: post._id!).isEmpty) {
                        let realmpost = self.localDB.createDbPost(_id: post._id!, title: post.title!, postdescription: post.description!, type: post.type!, user_id: post.user_id!, post_image_filename: post.post_image_filename, post_audio_filename: post.post_audio_filename, date: post.date!)
                        self.localDB.savePost(post: realmpost)
                    }
                })
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
