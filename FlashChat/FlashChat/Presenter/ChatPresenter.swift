//
//  ChatPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import Foundation

protocol ChatPresenterProtocol: AnyObject {
    var messageCount: Int { get }
    func viewDidLoad()
    func getMessage(at index: Int) -> Message 
    
}

class ChatPresenter: ChatPresenterProtocol {
    var messages: [Message] = []
    
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
        messages =     [Message(body: "Hey", sender: "John"),
        Message(body: "Hey", sender: "Adam")]
    }
}
