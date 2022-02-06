//
//  SignupViewController.swift
//  Genie
//
//  Created by John Smith on 2/5/22.
//

import UIKit
import Firebase
import FirebaseCore

class SignupViewController: UIViewController {
    
    var email: String?
    var password: String?
    var handle: AuthStateDidChangeListenerHandle?

    // IMPORTED VARIABLES FROM INTERFACE BUILDER
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton! // don't use this because function already in interface builder
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // IF BUTTON WAS TAPPED
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
              print("email/password can't be empty")
              return
            }
        if (password == confirmPassword) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              if let error = error as? NSError {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                  // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                    print("operationNotAllowed")
                case .emailAlreadyInUse:
                  // Error: The email address is already in use by another account.
                    print("emailAlreadyInUse")
                case .invalidEmail:
                  // Error: The email address is badly formatted.
                    print("invalidEmail")
                case .weakPassword:
                  // Error: The password must be 6 characters long or more.
                    print("weakPassword")
                default:
                    print("Error: \(error.localizedDescription)")
                }
              } else {
                print("User signs up successfully")
                let newUserInfo = Auth.auth().currentUser
                let email = newUserInfo?.email
              }
            }
        }
        else {
            print("passwords must match")
            return
        }
    }
    
    
    
    // THE VIEW APPEARS, START LISTENING
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
        }
    }
    
    // THE VIEW DISAPPEARS, STOP LISTENING
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
