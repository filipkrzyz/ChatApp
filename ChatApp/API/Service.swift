//
//  Service.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 29/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import Firebase

struct Service {
     
    static func fetchUsers(completion: @escaping(([User]) -> Void)) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                
                if users.count == snapshot?.documents.count {
                   completion(users)
                }
            })
        }
    }
}
