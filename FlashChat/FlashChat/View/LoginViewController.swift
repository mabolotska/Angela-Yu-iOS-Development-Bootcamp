//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit
import FirebaseAuth

protocol LoginViewControllerProtocol: AnyObject {
    //it shows real actions
    func updatePlaceHolders(email: String, pass: String)
    func showLoading()
    func hideLoading()
    func showError(message: String)
    func navigateToVC()
}

class LoginViewController: UIViewController, LoginViewControllerProtocol, UITextFieldDelegate {
    var presenter: LoginPresenter!
    var model = LoginModel()
    
    private let imageTF: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "textfield")
        image.isUserInteractionEnabled = true
       
        return image
    }()
    private let imageTFTwo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "textfield")
        image.isUserInteractionEnabled = true
 
        return image
    }()
    
    private let emailTF: UITextField = {
        let textfield = UITextField()
        textfield.text = "1@2.com"
        return textfield
    }()
    private let passTF: UITextField = {
        let textfield = UITextField()
        textfield.text = "123456"
        textfield.isSecureTextEntry = true
       
        return textfield
    }()
    private let logBUtton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = UIColor(named: "BrandBlue")
        presenter = LoginPresenter(viewcontroller: self, model: model)
        presenter.viewDidLoad()
        emailTF.delegate = self
        passTF.delegate = self
        setupUI()
        logBUtton.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func logButtonTapped() {
//        guard let password = passTF.text else { return }
//        guard let email = emailTF.text else { return }
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//            guard let strongSelf = self else { return }
//            
//            if let error = error {
//                print(error)
//            }
//            else {
//                let vc = ChatViewController()
//                strongSelf.navigationController?.pushViewController(vc, animated: true)
//            }
//            
//        }
        guard let email = emailTF.text, !email.isEmpty,
              let password = passTF.text, !password.isEmpty else {
            showError(message: "Please enter both username and password")
            return
        }
        presenter.authenticate(email: email, password: password)
        
    }
    
  
    
    func setupViews() {

        [imageTF, imageTFTwo, logBUtton].forEach { view.addSubview($0) }
        imageTF.addSubview(emailTF)
        imageTFTwo.addSubview(passTF)
    }

    func setupUI() {
   
        
        imageTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(150)

        }
        
        imageTFTwo.snp.makeConstraints { make in
            make.top.equalTo(imageTF.snp.bottom)
            make.centerX.equalToSuperview()

        }

        passTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()

        }

      

        emailTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(25)
 
        }
        logBUtton.snp.makeConstraints { make in
            make.top.equalTo(imageTFTwo.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
        }
    }

    func updatePlaceHolders(email: String, pass: String) {
        emailTF.placeholder = email
        passTF.placeholder = pass
    }
    
    
    func showLoading() {
    activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
          present(alertController, animated: true, completion: nil)
    }
    
    func navigateToVC() {
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
