//
//  AddNoteViewController.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 18/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class AddNoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var importBtn: UIButton!
    
    @IBOutlet weak var noteTitle: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Note"
        
        imagePicker.delegate = self
        
        importBtn.addTarget(self, action: #selector(loadImageButtonTapped), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func save() {
        guard let userId = Auth.auth().currentUser?.value(forKey: "uid") else { return }
        guard let title = noteTitle.text else { return }
        
        let file = "\(title).jpg"
        let imageRef = Storage.storage().reference().child(file)
        
        guard let image = imageView.image else { return }
        
        FirebaseRepo.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
    
            FirebaseRepo.addNote(title: title, user: userId as! String, image: urlString)

            
            let alertController = UIAlertController(title: "Note added to database", message: nil, preferredStyle: .alert)
            self.present(alertController, animated: true)
    
            let timer = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: timer){
                alertController.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    
    }
    
    
    

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
}
