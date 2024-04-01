//
//  ViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 25/03/24.
//

import UIKit
import SnapKit
import GhostTypewriter
import Firebase
import FirebaseAuth


protocol WelcomeVCProtocol: AnyObject {
    func updateLabel(label: String)
}

class WelcomeViewController: UIViewController, WelcomeVCProtocol {
    var presenter: WelcomePresenter!
  
    
    let flashLabel: TypewriterLabel = {
        let label = TypewriterLabel()
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    let regButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "BrandLightBlue")
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor(named: "BrandBlue"), for: .normal)
        return button
    }()
    let logButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = UIColor(named: "BrandBlue")
        return button
    }()
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupUI()
        view.backgroundColor = .white
        presenter = WelcomePresenter(viewController: self, text: WelcomeModel())
        presenter.viewDidLoad()
        regButton.addTarget(self, action: #selector(regButtonTapped), for: .touchUpInside)
        logButton.addTarget(self, action: #selector(logButtonTapped), for: .touchUpInside)
        flashLabel.startTypewritingAnimation()
        flashLabel.typingTimeInterval = 1
    }
    
    func setupViews() {
        [flashLabel, regButton, logButton].forEach {view.addSubview($0)}
    }
    func updateLabel(label: String) {
        flashLabel.text = label
    }

    @objc func regButtonTapped() {
       
        
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func logButtonTapped() {
     let vc = LoginViewController()
     navigationController?.pushViewController(vc, animated: true)
    }
}

extension WelcomeViewController {
    func setupUI() {
        flashLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        logButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-30)
            make.leading.trailing.equalToSuperview()
        }
        
        regButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.bottom.equalTo(logButton.snp.top).offset(-20)
            make.leading.trailing.equalToSuperview()
        }
    }
}
