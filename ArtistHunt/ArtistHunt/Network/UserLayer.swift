//
//  UserLayer.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import Alamofire

class UserLayer {
    static func login(email: String, password: String, completion:@escaping (Result<User>)->Void) {
        AF.request(UserRouterApi.login(email: email, password: password))
            .responseDecodable { (response: DataResponse<User>) in
                completion(response.result)
        }
    }
}
