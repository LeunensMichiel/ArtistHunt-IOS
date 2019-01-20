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
    @IBOutlet weak var errorLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    private let localDB = ArtisthuntRealmDb()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registry_signUp(_ sender: Any) {
        view.endEditing(true)
        
        guard let email = registry_email_txf.text, email.count > 0 else {
            self.errorLabel.text = "No Email Entered"
            return
        }
        guard let password = registry_pass_txf.text, password.count > 0 else {
            self.errorLabel.text = "No Password Entered"
            return
        }
        guard let passwordRepeat = registry_passRepeat_txf.text, passwordRepeat.count > 0 else {
            self.errorLabel.text = "No Password Repeat Entered"
            return
        }
        guard let firstname = registry_firstname_txf.text, firstname.count > 0 else {
            self.errorLabel.text = "No Firstname Entered"
            return
        }
        guard let lastname = registry_lastname_txf.text, lastname.count > 0 else {
            self.errorLabel.text = "No Lastname Entered"
            return
        }
        
        if (password == passwordRepeat) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            RouterClient.register(email: email, password: password, firstname: firstname, lastname: lastname)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { result in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if (result.token != nil) {
                        //We place _id and token in the User Keychain
                        AuthenticationController.login(token: result.token!, _id: result._id!)
                        self.errorLabel.text = ""
                        if (self.localDB.findUserByID(by: result._id!).isEmpty) {
                            let dbUser = self.localDB.createDbUser(_id: result._id!, email: result.email!, firstname: result.firstname!, lastname: result.lastname!, token: result.token!, profileImage: result.profile_image_filename)
                            self.localDB.saveUser(user: dbUser)
                        }
                        
                        self.performSegue(withIdentifier: "registerSegue", sender: self)
                    } else {
                        self.errorLabel.text = "Encountered a problem while registering"
                    }
                }, onError: { error in
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    switch error {
                    case APIErrorConstants.unAuthorized:
                        self.errorLabel.text = "Unauthorized"
                        print("401 error")
                    case APIErrorConstants.notFound:
                        self.errorLabel.text = "Error 404: Not Found"
                        print("404 error")
                    default:
                        self.errorLabel.text = "Oops, Something went wrong on our side!"
                        print("Unknown error:", error)
                    }
                })
                .disposed(by: disposeBag)
        } else {
            self.errorLabel.text = "Passwords do not match!"
        }
        
        
    }
    @IBAction func goBackToLogin(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLoginSegue", sender: self)
    }
    
}
