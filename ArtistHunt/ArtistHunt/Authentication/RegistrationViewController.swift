//
//  RegistrationViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var registry_email_txf: UITextField!
    @IBOutlet weak var registry_pass_txf: UITextField!
    @IBOutlet weak var registry_passRepeat_txf: UITextField!
    @IBOutlet weak var registry_firstname_txf: UITextField!
    @IBOutlet weak var registry_lastname_txf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registry_signUp(_ sender: Any) {
    }
    @IBAction func goBackToLogin(_ sender: Any) {
        performSegue(withIdentifier: "unwindToLoginSegue", sender: self)
    }
    
}
