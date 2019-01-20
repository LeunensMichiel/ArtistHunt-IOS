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
    
    static func addPost(title: String, description: String, type: String, user_id: String, date: String) -> Observable<Post> {
        return request(RouterApi.post(title: title, description: description, type: type, user_id: user_id, date: date))
    }
    
    static func addImagePost(title: String, description: String, type: String, user_id: String, date: String, image: Data) -> Observable<Post> {
        let parameters = [Constants.APIParameterKey.title: title, Constants.APIParameterKey.description: description, Constants.APIParameterKey.type: type, Constants.APIParameterKey.user_id: user_id, Constants.APIParameterKey.date: date]
        
        let headers: HTTPHeaders = [
            "Authorization": AuthenticationController.getToken()!,
            "Content-type": "multipart/form-data"
        ]

        return Observable<Post>.create { observer in
            let request = AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                multipartFormData.append(image, withName: "file", fileName: "file.jpg", mimeType: "image/jpeg")
            }, to: "http://projecten3studserver03.westeurope.cloudapp.azure.com:3001/API/post/post/image", method: .put, headers: headers)
//            { (result) in
//                switch result {
//                case .success(let value):
//                    observer.onNext(value)
//                    observer.onCompleted()
//                case .failure(let error):
//                    switch response.response?.statusCode {
//                    case 401:
//                        observer.onError(APIErrorConstants.unAuthorized)
//                    case 404:
//                        observer.onError(APIErrorConstants.notFound)
//                    case 500:
//                        observer.onError(APIErrorConstants.internalServerError)
//                    default:
//                        observer.onError(error)
//                    }
//                }
            return Disposables.create {
                request.cancel()
            }
        }
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
