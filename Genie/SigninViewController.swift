//
//  SigninViewController.swift
//  Genie
//
//  Created by John Smith on 12/22/21.
//

import UIKit
import Firebase
import FirebaseCore

class SigninViewController: UIViewController {
    
    var email: String?
    var password: String?
    var handle: AuthStateDidChangeListenerHandle?

    // IMPORTED VARIABLES FROM INTERFACE BUILDER
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // IF THE SIGN IN BUTTON WAS TAPPED
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
              print("email/password can't be empty")
              return
            }
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
          if let error = error as? NSError {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
              // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                print("operationNotAllowed")
            case .userDisabled:
              // Error: The user account has been disabled by an administrator.
                print("userDisabled")
            case .wrongPassword:
              // Error: The password is invalid or the user does not have a password.
                print("wrongPassword")
            case .invalidEmail:
              // Error: Indicates the email address is malformed.
                print("invalidEmail")
            default:
                print("Error: \(error.localizedDescription)")
            }
          } else {
              print("User signs in successfully")
              let userInfo = Auth.auth().currentUser
              let email = userInfo?.email
              
              // Instantiate tabbarcontroller
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let mainTabBarController = storyboard.instantiateViewController(identifier: "TabBarController")
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
              print("tried to push screen")
            
          }
        }
    }
    
    // TO RETURN TO THIS SCREEN
    @IBAction func myUnwindActionSignIn(unwindSegue: UIStoryboardSegue) {
    }
    
    // THE VIEW APPEARS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // WILL RUN IF BUTTON IS PRESSED AND USER/PASS IS CORRECT
            if let user = user {
                
              // The user's ID, unique to the Firebase project.
              // Do NOT use this value to authenticate with your backend server,
              // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                var multiFactorString = "MultiFactor: "
                for info in user.multiFactor.enrolledFactors {
                multiFactorString += info.displayName ?? "[DispayName]"
                multiFactorString += " "
                }
                // ...
                
            }
        }
    }
    
    // THE VIEW DISAPPEARS
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        Auth.auth().removeStateDidChangeListener(handle!)
        // [END remove_auth_listener]
      }
    
    


}

