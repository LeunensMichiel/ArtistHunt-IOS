//
//  AuthenticationController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthenticationController {
    
    static func login(token: String, _id: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: "userToken")
        keychain.set(_id, forKey: "userID")

    }
    
    static func getToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userToken")
    }
    
    static func getUserId() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userID")
    }
    
    static func logout() {
        let keychain = KeychainSwift()
        keychain.delete("userToken")
        keychain.delete("userID")

    }
}
