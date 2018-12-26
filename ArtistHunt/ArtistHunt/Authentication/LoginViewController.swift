//
//  LoginViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var login_email_textfield: UITextField!
    @IBOutlet weak var login_password_textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func login(_ sender: Any) {
        if let email = login_email_textfield.text, let password = login_password_textfield.text {
            UserLayer.login(email: email, password: password) { result in
                switch result {
                case .success(let user):
                    print(user)
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {}

}
