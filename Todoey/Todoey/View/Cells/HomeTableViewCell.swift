//
//  HomeTableViewCell.swift
//  Todoey
//
//  Created by Maryna Bolotska on 11/04/24.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(model: Item) {
        nameLabel.text = model.name
    }
    
}

private extension HomeTableViewCell {
    func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
        }
    }
}
