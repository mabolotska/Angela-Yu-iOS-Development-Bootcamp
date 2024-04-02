//
//  ChatPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import Foundation
import FirebaseFirestore

protocol ChatPresenterProtocol: AnyObject {
    var messageCount: Int { get }
    func viewDidLoad()
    func getMessage(at index: Int) -> Message 
    func sendMessage(messageBody: String, messageSender: String)

}

class ChatPresenter: ChatPresenterProtocol {
  
    
    
    
    var messages: [Message] = []
    let db = Firestore.firestore()
    
    weak private var viewController: ChatViewController?
    var model: ChatModel
    
    init(viewController: ChatViewController? = nil, model: ChatModel) {
        self.viewController = viewController
        self.model = model
    }
    
    var messageCount: Int {
        return messages.count
    }
    
    func getMessage(at index: Int) -> Message {
        return messages[index]
    }
    
    func viewDidLoad() {
//        messages =     [Message(body: "Hey", sender: "John"),
//        Message(body: "Hey", sender: "Adam")]
        loadMessages()
    }
    
    func sendMessage(messageBody: String, messageSender: String) {
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { (error) in

            if let e = error {
                print(e)
            }
        }
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            self.messages = []
            
            if let e = error {
                print(e)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(body: messageBody, sender: messageSender)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.viewController?.reloadTableView(at: indexPath)

                            }
                            
                     
                        }
                    }
                }
            }
        }
    }
    

}
