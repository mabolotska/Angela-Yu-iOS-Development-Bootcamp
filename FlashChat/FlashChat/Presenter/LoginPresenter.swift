//
//  LoginPresenter.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import Foundation
import FirebaseAuth

protocol LoginPresenterProtocol {
    func viewDidLoad()
    func authenticate(email: String, password: String)
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
    
    func authenticate(email: String, password: String) {
        viewcontroller?.showLoading()
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                // An error occurred during authentication
                strongSelf.viewcontroller?.hideLoading()
                strongSelf.viewcontroller?.showError(message: error.localizedDescription)
            } else {
                // Authentication succeeded
                strongSelf.viewcontroller?.hideLoading()
                strongSelf.viewcontroller?.navigateToVC()
            }
        }
    }
}
