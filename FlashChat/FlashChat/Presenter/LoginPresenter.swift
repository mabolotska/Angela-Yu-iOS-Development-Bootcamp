//
//  LoginPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import Foundation

protocol LoginPresenterProtocol {
    func viewDidLoad()
}

class LoginPresenter: LoginPresenterProtocol {
    weak var viewcontroller: LoginViewController?
    var model: LoginModel
    
    required init(viewcontroller: LoginViewController? = nil, model: LoginModel) {
        self.viewcontroller = viewcontroller
        self.model = model
    }
    
    func viewDidLoad() {
        viewcontroller?.updatePlaceHolders(email: model.emailText, pass: model.passText)
    }
    
    
}
