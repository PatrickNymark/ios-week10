//
//  FirebaseRepo.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 17/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class FirebaseRepo {
    
    private static let db = Firestore.firestore() // gets the Firebase instance
    
    static func startListener(vc: NoteViewController){
        let userID = Auth.auth().currentUser?.uid
        
        
        db.collection("notes").whereField("user", isEqualTo: userID).addSnapshotListener { (snap, error) in
            if error != nil {  // check if there is an error. If so, then return
                print("error")
                return
            }
            
            var notes = [Note]()
            
            for doc in snap!.documents {
                let data = doc.data()
                let title = data["title"] as! String
                let user = data["user"] as! String
                let image = data["image"] as! String
                
                let newNote = Note(title: title, user: user, image: image)
                
                notes.append(newNote)
            }
            
            vc.updateNotes(notes: notes)
        }
    }
    
    static func addNote(title:String, user: String, image: String) {
        let ref = db.collection("notes")
        let newNote = Note(title: title, user: user, image: image)

        ref.addDocument(data: newNote.dictionary)
        
    }
    
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            return completion(nil)
        }
        
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
    
}
