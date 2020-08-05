//
//  RegisterViewController.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 18/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    var authManager:AuthManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authManager = AuthManager(parentVC: self)
        
        registerBtn.addTarget(self, action: #selector(self.registerUser), for: .touchUpInside)

    }
    
    @objc func registerUser() {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        authManager?.signUp(email: email, pwd: password)
    }

}
