//
//  ChatCell.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit

class ChatCell: UITableViewCell {
    static let reuseID = "ChatCell"
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let senderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(info: Message) {
        bodyLabel.text = info.body
        senderLabel.text = info.sender
    }

    private func configure() {
        [bodyLabel, senderLabel].forEach { addSubview($0)}
    }
    
    func setupConstraints() {
        senderLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
        }
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(senderLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(5)
        }
    }
}
