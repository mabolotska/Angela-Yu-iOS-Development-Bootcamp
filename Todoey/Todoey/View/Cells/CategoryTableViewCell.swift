//
//  CategoryTableViewCell.swift
//  Todoey
//
//  Created by Maryna Bolotska on 13/04/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    static let identifier = "CategoryTableViewCell"
    private let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func set(model: Category) {
        nameLabel.text = model.name
    }

}

private extension CategoryTableViewCell {
    func setupUI() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
    }
}
