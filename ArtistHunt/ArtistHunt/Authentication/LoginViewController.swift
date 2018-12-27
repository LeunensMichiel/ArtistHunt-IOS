//
//  LoginViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {
    @IBOutlet weak var login_email_textfield: UITextField!
    @IBOutlet weak var login_password_textfield: UITextField!
    private let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        
        guard let email = login_email_textfield.text, email.count > 0 else {
            return
        }
        guard let password = login_password_textfield.text, password.count > 0 else {
            return
        }
        
        if let email = login_email_textfield.text, let password = login_password_textfield.text {
            UserClient.login(email: email, password: password)
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { result in
                    print(result)
                    if (result.token != nil) {
                        AuthenticationController.login(token: result.token!)
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
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
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}

}
