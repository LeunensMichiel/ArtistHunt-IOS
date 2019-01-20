//
//  UserViewModel.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 20/01/2019.
//  Copyright © 2019 Leunes Media. All rights reserved.
//

import Foundation
import RealmSwift

class UserViewModel {
    private let localDB = ArtisthuntRealmDb()
    
    lazy var user: Results<RealmUser> = {
        localDB.findUserByID(by: AuthenticationController.getUserId()!)
    }()
}


