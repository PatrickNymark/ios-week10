//
//  AuthManager.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 18/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthManager{
    
    var auth = Auth.auth() // Firebase authentication class.
    let parentVC:UIViewController
    
    init(parentVC:UIViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("Status: user is logged in: \(user)") // show some GUI
            }else {
                print("Status: user is logged out") // hide content
            }
        }
    }
    
    func signUp(email:String, pwd:String) {
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully signed up to Firebase \(result.debugDescription)")
                
            self.parentVC.navigationController?.popToRootViewController(animated: true)
                
            }else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
    func signIn(email:String, pwd:String) {
        auth.signIn(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully logged in to Firebase \(result.debugDescription)")

                self.parentVC.performSegue(withIdentifier: "loginToNotes", sender: self.parentVC)
            }else {
                print("Failed to log in \(error.debugDescription)")
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            
            self.parentVC.performSegue(withIdentifier: "notesToView", sender: self.parentVC)
        }catch let error{
            print("error signing out \(error.localizedDescription)")
        }
    }
    
}
