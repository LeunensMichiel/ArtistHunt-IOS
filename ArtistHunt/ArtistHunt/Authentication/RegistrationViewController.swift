//
//  RegistrationViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit
import RxSwift

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var registry_email_txf: UITextField!
    @IBOutlet weak var registry_pass_txf: UITextField!
    @IBOutlet weak var registry_passRepeat_txf: UITextField!
    @IBOutlet weak var registry_firstname_txf: UITextField!
    @IBOutlet weak var registry_lastname_txf: UITextField!
    
    private let disposeBag = DisposeBag()
    private let localDB = ArtisthuntRealmDb()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registry_signUp(_ sender: Any) {
        view.endEditing(true)
        
        guard let email = registry_email_txf.text, email.count > 0 else {
            return
        }
        guard let password = registry_pass_txf.text, password.count > 0 else {
            return
        }
        guard let passwordRepeat = registry_passRepeat_txf.text, passwordRepeat.count > 0 else {
            return
        }
        guard let firstname = registry_firstname_txf.text, firstname.count > 0 else {
            return
        }
        guard let lastname = registry_lastname_txf.text, lastname.count > 0 else {
            return
        }
        
        if (password == passwordRepeat) {
            RouterClient.register(email: email, password: password, firstname: firstname, lastname: lastname)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { result in
                    print(result)
                    if (result.token != nil) {
                        //We place _id and token in the User Keychain
                        AuthenticationController.login(token: result.token!, _id: result._id!)
                        
                        if (self.localDB.findUserByID(by: result._id!).isEmpty) {
                            let dbUser = self.localDB.createDbUser(_id: result._id!, email: result.email!, firstname: result.firstname!, lastname: result.lastname!, token: result.token!, profileImage: result.profile_image_filename)
                            self.localDB.saveUser(user: dbUser)
                        }
                        
                        self.performSegue(withIdentifier: "registerSegue", sender: self)
                    }
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
    @IBAction func goBackToLogin(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLoginSegue", sender: self)
    }
    
}
