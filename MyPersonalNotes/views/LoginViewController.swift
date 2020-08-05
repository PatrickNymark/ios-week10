//
//  AuthViewController.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 18/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var authManager:AuthManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Login"
        
        authManager = AuthManager(parentVC: self)
        
        button.addTarget(self, action: #selector(signIn), for: .touchDown)
    }

    @objc func signIn(_ sender: UIButton) {
        if let email = emailField.text, let pwd = passwordField.text { // check if there is enough text
            if email.count > 5 && pwd.count > 5{
                authManager?.signIn(email: email, pwd: pwd)
            }
        }
    }
    

}
