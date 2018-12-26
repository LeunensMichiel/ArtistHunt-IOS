//
//  APIErrorConstants.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation

enum APIErrorConstants: Error {
    case unAuthorized
    case notFound
    case internalServerError
}
