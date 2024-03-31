//
//  RegisterPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import Foundation

protocol RegisterPresenterProtocol {
    func viewDidLoad()
}

class RegisterPresenter: RegisterPresenterProtocol {
    weak var viewcontroller: RegisterViewController?
    var model: RegisterModel
    
    required init(viewcontroller: RegisterViewController? = nil, model: RegisterModel) {
        self.viewcontroller = viewcontroller
        self.model = model
    }
    
    func viewDidLoad() {
        viewcontroller?.updatePlaceHolders(email: model.emailText, pass: model.passText)
    }
    
    
}
