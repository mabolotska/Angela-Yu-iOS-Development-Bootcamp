//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit

protocol ChatViewControllerProtocol: AnyObject {
    func reloadTableView()
}


class ChatViewController: UIViewController, ChatViewControllerProtocol {
   
    
    var presenter: ChatPresenter!
    var model = ChatModel()
    
//    required init(presenter: ChatPresenter!, model: ChatModel) {
//        
//        self.presenter = presenter
//        self.model = model
//     
//    }
    

  
    
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
        textfield.layer.cornerRadius = 5
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
        configureTableView()
        setViews()
        setupUI()
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
        
        
        purpleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
            make.bottom.equalToSuperview()
        }
        messageTF.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(40)
            make.width.equalTo(230)
            make.height.equalTo(50)
        }
        sendButton.snp.makeConstraints { make in
            make.centerY.equalTo(messageTF)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
    func reloadTableView() {
        
    }
    
    func configureTableView() {
        tableView.rowHeight = 96
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatCell.self, forCellReuseIdentifier: ChatCell.reuseID)
    }
    
    @objc func exitButtonTapped() {
        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.reuseID) as! ChatCell
//       let bookmark = presenter.getBookmark(at: indexPath.row)
//        cell.set(info: bookmark)
        return cell
    }
    
    
}
