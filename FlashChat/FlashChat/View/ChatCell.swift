//
//  ChatCell.swift
//  FlashChat
//
//  Created by Maryna Bolotska on 31/03/24.
//

import UIKit

class ChatCell: UITableViewCell {
    static let reuseID = "ChatCell"
    
     let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: K.BrandColors.purple)
        view.layer.cornerRadius = 20
        return view
    }()
    
     let bodyLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
       
        return label
    }()
//    private let senderLabel: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    let senderImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "MeAvatar")
        return image
    }()
    let anotherSenderImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "YouAvatar")
        return image
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
  //      senderLabel.text = info.sender
    }

    private func configure() {
        addSubview(purpleView)
        purpleView.addSubview(bodyLabel)
        addSubview(senderImage)
        addSubview(anotherSenderImage)
    }
    
    func setupConstraints() {
        purpleView.snp.makeConstraints { make in
           make.top.equalToSuperview().offset(20)
            make.leading.equalTo(anotherSenderImage.snp.trailing).offset(10)
            make.trailing.equalTo(senderImage.snp.leading).offset(-10)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-5)

        }
        bodyLabel.snp.makeConstraints { make in
        //    make.centerY.equalToSuperview()
            make.leading.top.equalToSuperview().offset(10)
        }
        senderImage.snp.makeConstraints { make in
          //  make.height.equalToSuperview().offset(5)
            make.height.equalTo(60)
            make.width.equalTo(senderImage.snp.height)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        anotherSenderImage.snp.makeConstraints { make in
          //  make.height.equalToSuperview().offset(5)
            make.height.equalTo(60)
            make.width.equalTo(senderImage.snp.height)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
}
