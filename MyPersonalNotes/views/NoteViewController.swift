//
//  NoteViewController.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 17/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    var authManager:AuthManager?
    var notes = [Note]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide navigation back btn
        self.navigationItem.setHidesBackButton(true, animated: true)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        // register custom cell
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")

        
        // add listener for logout navigation button
        if let logoutBtn = navigationItem.leftBarButtonItem {
            logoutBtn.target = self
            logoutBtn.action = #selector(logout)
        }

        authManager = AuthManager(parentVC: self)

        FirebaseRepo.startListener(vc: self)
    }
    
    @objc func logout() {
        authManager?.signOut()
    }
    

    func updateNotes(notes: [Note]) {
        self.notes.removeAll()
        
        for note in notes {
            self.notes.append(note)
        }
        
        tableView.reloadData()
    }
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
//        cell.layoutMargins = UIEdgeInsets.zero
        cell.cellTitle.text = notes[indexPath.row].title
        
        let url = URL(string: notes[indexPath.row].image)
        
        // download image async
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                cell.cellImage.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}

