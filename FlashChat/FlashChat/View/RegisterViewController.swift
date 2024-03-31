//
//  RegisterViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit

protocol RegisterViewControllerProtocol {
    //it shows real actions
    func updatePlaceHolders(email: String, pass: String)
}

class RegisterViewController: UIViewController, RegisterViewControllerProtocol, UITextFieldDelegate {
    var presenter: RegisterPresenter!
    var model = RegisterModel()
    
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
   //     textfield.placeholder = "Email"
    
        return textfield
    }()
    private let passTF: UITextField = {
        let textfield = UITextField()
    //    textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
       
        return textfield
    }()
    private let logBUtton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = UIColor(named: "BrandLightBlue")
        presenter = RegisterPresenter(viewcontroller: self, model: model)
        presenter.viewDidLoad()
        emailTF.delegate = self
        passTF.delegate = self
        setupUI()
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
}

