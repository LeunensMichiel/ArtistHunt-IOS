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
    
    static func login(token: String) {
        let keychain = KeychainSwift()
        keychain.set(token, forKey: "userToken")
    }
    
    static func getToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get("userToken")
    }
    
    static func logout() {
        let keychain = KeychainSwift()
        keychain.delete("userToken")
    }
}
