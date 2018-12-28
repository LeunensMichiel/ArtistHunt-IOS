//
//  UserLayer.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 26/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RouterClient {    
    static func login(email: String, password: String) -> Observable<User> {
        return request(RouterApi.login(email: email, password: password))
    }
    
    static func register(email: String, password: String, firstname: String, lastname: String) -> Observable<User> {
        return request(RouterApi.register(email: email, password: password, firstname: firstname, lastname: lastname))
    }
    
    static func getPosts() -> Observable<Array<Post>> {
        return request(RouterApi.posts)
    }
    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(.postFormatter)
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseDecodable (decoder: jsonDecoder) { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    switch response.response?.statusCode {
                    case 401:
                        observer.onError(APIErrorConstants.unAuthorized)
                    case 404:
                        observer.onError(APIErrorConstants.notFound)
                    case 500:
                        observer.onError(APIErrorConstants.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }
        
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
