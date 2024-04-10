//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit


protocol ChatViewControllerProtocol: AnyObject {
    func reloadTableView(at indexPath: IndexPath)
    func scrollToRow(at indexPath: IndexPath) //to open vc with last sent message
}


class ChatViewController: UIViewController, ChatViewControllerProtocol {
   
    
   
    
    var presenter: ChatPresenter!
    var model = ChatModel()
 
    
    var textFieldBottomConstraint: Constraint?
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
        title = K.appName
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        presenter = ChatPresenter(viewController: self, model: model)
        presenter.viewDidLoad()
        configureTableView()
        setViews()
        setupUI()
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), 
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
    }
    deinit {
           // Unregister keyboard notifications
           NotificationCenter.default.removeObserver(self)
       }
    
    @objc func sendPressed() {
        guard let messageBody = messageTF.text, !messageBody.isEmpty else {return}
        guard let messageSender = Auth.auth().currentUser?.email, !messageSender.isEmpty else {return }
        presenter.sendMessage(messageBody: messageBody, messageSender: messageSender)
        
        messageTF.text = ""
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
            textFieldBottomConstraint = make.bottom.equalToSuperview().constraint
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
    
    func reloadTableView(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
             }
    }
    func configureTableView() {
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
        if message.sender == Auth.auth().currentUser?.email {
            cell.senderImage.isHidden = true
            cell.anotherSenderImage.isHidden = false
            cell.purpleView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.bodyLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            cell.senderImage.isHidden = false
            cell.anotherSenderImage.isHidden = true
            cell.purpleView.backgroundColor = UIColor(named: K.BrandColors.lighBlue)
            cell.bodyLabel.textColor = UIColor(named: K.BrandColors.blue)
        }
        return cell
    }
    
    func scrollToRow(at indexPath: IndexPath) {

        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}


extension ChatViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               // Adjust the position of the text field when the keyboard appears
               let keyboardHeight = keyboardSize.height
               UIView.animate(withDuration: 0.3) {
                   self.textFieldBottomConstraint?.update(offset: -keyboardHeight) // Update the bottom constraint
                   self.view.layoutIfNeeded()
               }
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           // Reset the position of the text field when the keyboard hides
           UIView.animate(withDuration: 0.3) {
               self.textFieldBottomConstraint?.update(offset: 0) // Update the bottom constraint
               self.view.layoutIfNeeded()
           }
       }
}
