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
    
}

class ChatPresenter: ChatPresenterProtocol {
  
    
    weak private var viewController: ChatViewController?
    var model: ChatModel
    
    init(viewController: ChatViewController? = nil, model: ChatModel) {
        self.viewController = viewController
        self.model = model
    }
    
    var messageCount: Int {
        return 1
    }
    
    func viewDidLoad() {
        
    }
}
