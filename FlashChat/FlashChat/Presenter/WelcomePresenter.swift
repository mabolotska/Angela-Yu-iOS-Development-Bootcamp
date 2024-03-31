//
//  WelcomePresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 30/03/24.
//

import Foundation
protocol WelcomePresenterProtocol {
    func viewDidLoad()
}

class WelcomePresenter: WelcomePresenterProtocol {
    weak var viewController: WelcomeViewController?
    var model: WelcomeModel
    
    required init(viewController: WelcomeViewController? = nil, text: WelcomeModel) {
        self.viewController = viewController
        self.model = text
    }
    func viewDidLoad() {
        
        viewController?.updateLabel(label: model.mainLabelText)
    }
    
    
}
