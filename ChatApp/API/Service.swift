//
//  Service.swift
//  ChatApp
//
//  Created by Filip Krzyzanowski on 29/10/2020.
//  Copyright © 2020 Filip Krzyzanowski. All rights reserved.
//

import FirebaseAuth
import FirebaseFirestore

struct Service {
    
    private static var messagesListener: ListenerRegistration?
    private static var conversationsListener: ListenerRegistration?
     
    static func fetchUsers(completion: @escaping(([User]) -> Void)) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data()) }) else { return }
            
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
            
            // Remove the current user
            if let i = users.firstIndex(where: { $0.uid == currentUid }) {
                users.remove(at: i)
            }
            
            users = users.sorted{$0.username < $1.username}
            
            completion(users)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchConversations(completion: @escaping([String: Conversation]) -> Void) {
        var conversationsDict = [String: Conversation]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else {
            completion(conversationsDict)
            return
        }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").order(by: "timestamp")
        
        conversationsListener = query.addSnapshotListener { (snapshot, error) in
            
            
            guard let changes = snapshot?.documentChanges, changes.count != 0 else {
                completion(conversationsDict)
                return
            }
            
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                self.fetchUser(withUid: message.chatPartnerId) { user in
                    let conversation = Conversation(user: user, message: message)
                    
                    conversationsDict[user.uid] = conversation
                    completion(conversationsDict)
                    
                }
                
            })
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        
        messagesListener = query.addSnapshotListener { (snapshot, error) in
            
            guard snapshot?.documentChanges.count != 0 else {
                completion(messages)
                return
            }
            
            snapshot?.documentChanges.forEach({ change in
                
                if change.type == .added {
                    let dictionary = change.document.data()
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["text": message,
                    "fromId": currentUid,
                    "toId": user.uid,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data) { _ in
                COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data, completion: completion)
                }
            }
        }
    }
    
    static func removeListeners() {
        messagesListener?.remove()
        conversationsListener?.remove()
    }
    
}
