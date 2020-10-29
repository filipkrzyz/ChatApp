//
//  AuthService.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 29/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let email: String
    let fullname: String
    let username: String
    let password: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(credentials: RegistrationCredentials, completion: @escaping((Error?) -> Void)) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let storageReference = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        storageReference.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print(">>> Failed to uplaod image with error: \(error)")
                return
            }
            
            storageReference.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                    if let error = error {
                        print(">>> Failed to create user with error: \(error)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let data = ["uid": uid,
                                "email": credentials.email,
                                "fullname": credentials.fullname,
                                "username": credentials.username,
                                "profileImageUrl": profileImageUrl]
                    
                    Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
                }
            }
        }
    }
    
}
