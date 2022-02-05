//
//  SigninViewController.swift
//  Genie
//
//  Created by John Smith on 12/22/21.
//

import UIKit

class SigninController: UIViewController {
    
    var email = "email"
    var password = "password"

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func myUnwindActionSignIn(unwindSegue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }
    
    


}

