//
//  Note.swift
//  MyPersonalNotes
//
//  Created by Patrick Nymark on 17/05/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import Foundation

struct Note {
    var title:String = ""
    var user:String = ""
    var image:String = ""
    
    var dictionary: [String: Any] {
        return ["title": title, "user": user, "image": image]
    }
    
    init(title: String, user: String, image: String) {
        self.title = title
        self.user = user
        self.image = image
    }
    
    
}
