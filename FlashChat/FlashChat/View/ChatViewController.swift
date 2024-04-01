//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit
import FirebaseAuth

protocol ChatViewControllerProtocol: AnyObject {
    func reloadTableView()
}


class ChatViewController: UIViewController, ChatViewControllerProtocol {
   
    
    var presenter: ChatPresenter!
    var model = ChatModel()
    
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        return view
    }()
    
    private let tableView = UITableView()
    private lazy var exitButton = UIBarButtonItem(image: UIImage(systemName: "person.slash"), style: .plain, target: self, action: #selector(exitButtonTapped))
    private let messageTF: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "  Write a message"
        textfield.layer.cornerRadius = 20
        textfield.backgroundColor = .white
        return textfield
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        presenter = ChatPresenter(viewController: self, model: model)
        presenter.viewDidLoad()
        configureTableView()
        setViews()
        setupUI()
        navigationItem.hidesBackButton = true
        
    }
    
  
    
    func setViews() {
        [tableView, purpleView].forEach {view.addSubview($0)}
        purpleView.addSubview(messageTF)
        purpleView.addSubview(sendButton)
    }
    
    func setupUI() {
        exitButton.tintColor = .white
        navigationItem.rightBarButtonItem = exitButton
 //       exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(purpleView.snp.top)
        }
        
        purpleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
        messageTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(240)
            make.height.equalTo(40)
        }
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(messageTF)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func configureTableView() {
        tableView.rowHeight = 96
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseID)
        tableView.backgroundColor = .white
    }
    
    @objc func exitButtonTapped() {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                navigationController?.popViewController(animated: true)
                
            } catch let signOutError as NSError {
                print(signOutError)
            }
        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseID) as! ChatCell
       let message = presenter.getMessage(at: indexPath.row)
        cell.set(info: message)
        return cell
    }
    
    
}
