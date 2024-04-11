//
//  ViewController.swift
//  Todoey
//
//  Created by Maryna Bolotska on 10/04/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var viewModel = ItemViewModel()
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //set navbar color in appdelegate
      //  navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        view.backgroundColor = .white
        title = "Todoey"
        setViews()
        setupUI()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "add"), style: .done, target: self, action: #selector(addButtonPressed))
    }
    @objc func addButtonPressed() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
//            
//            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
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
            make.trailing.leading.top.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell() }
        let item = viewModel.items[indexPath.row]
        cell.set(model: item)
  //      cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
  
}


