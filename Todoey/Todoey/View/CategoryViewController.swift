//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Maryna Bolotska on 13/04/24.
//

import UIKit

class CategoryViewController: UIViewController {
    var viewModel = CategoryViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Todoey. Select Category"
        setViews()
        setupUI()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addButtonPressed))
        viewModel.loadItems()
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    @objc func addButtonPressed() {
        var textField = UITextField()

        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { _ in
            self.viewModel.addCategories(text: textField)
    //        self.viewModel.saveItems()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField

        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    func setViews() {
        [tableView].forEach {view.addSubview($0)}
    }
    func setupUI() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }

}


extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else { return UITableViewCell() }
        guard let category = viewModel.categories?[indexPath.row] else { return cell }

        cell.set(model: category)

        tableView.deselectRow(at: indexPath, animated: true)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HomeViewController()
        vc.viewModel.selectedCategory = viewModel.categories?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
