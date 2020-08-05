//
//  ViewController.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 18/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
//            self.navigationController?.isNavigationBarHidden = true
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "viewToNotes", sender: self)
        } else {
            //User Not logged in
            self.navigationItem.setHidesBackButton(true, animated: true);
        }

        // Do any additional setup after loading the view.
    }
    
    
}
