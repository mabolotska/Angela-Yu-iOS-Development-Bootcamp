//
//  RegisterPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit
import FirebaseAuth

protocol RegisterPresenterProtocol {
    func viewDidLoad()
    func authenticate(email: String, password: String)
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
    
    func authenticate(email: String, password: String) {
        viewcontroller?.showLoading()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                // An error occurred during authentication
                self.viewcontroller?.hideLoading()
                self.viewcontroller?.showError(message: error.localizedDescription)
            } else {
                // Authentication succeeded
                self.viewcontroller?.hideLoading()
                self.viewcontroller?.navigateToVC()
            }
        }
    }
}
