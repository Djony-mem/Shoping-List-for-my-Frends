//
//  Users.swift
//  Shoping List for my Frends
//
//  Created by Brubrusha on 12/7/20.
//

import Foundation
import Firebase

struct AppUser {
    let uid: String
    let email: String
    var items: [Item] = []
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
