//
//  ViewController.swift
//  Todoey
//
//  Created by Maryna Bolotska on 10/04/24.
//

import UIKit
import SnapKit
import CoreData
import RealmSwift

class HomeViewController: UIViewController {
    var viewModel = ItemViewModel()
    private let tableView = UITableView()
    private let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.red // your colour here
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        view.backgroundColor = .white
        title = "Todoey"
        setViews()
        setupUI()
        configureTableView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addButtonPressed))
        viewModel.onDataUpdate = { [weak self] in
            // Reload tableView on the main thread
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

        }
        viewModel.loadItems()
        searchBar.delegate = self
    }
    @objc func addButtonPressed() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            self.viewModel.items.append(Item(textField.text!))
//                        self.viewModel.saveItems()
//                        self.tableView.reloadData()

            
            self.viewModel.addItems(text: textField)
   // for core data         self.viewModel.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func setViews() {
        [tableView, searchBar].forEach {view.addSubview($0)}
    }
    func setupUI() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview()
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
        // If there are no items, display one row for "No data" message
        return viewModel.items?.count ?? 0 > 0 ? viewModel.items!.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell() }
        guard let items = viewModel.items, !items.isEmpty else {
                cell.nameLabel.text = "No data"
                cell.accessoryType = .none
                return cell
            }

            // If there are items, proceed as usual
            let item = items[indexPath.row]
            cell.set(model: item)
            cell.accessoryType = item.isDone ? .checkmark : .none
            tableView.deselectRow(at: indexPath, animated: true)
            return cell
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //      viewModel.items?[indexPath.row].isDone = !viewModel.items?[indexPath.row].isDone
//        guard let item = viewModel.items?[indexPath.row] else { return }
//            do {
//                try realm.write {
//                    item.isDone = !item.isDone
//                }
//            } catch {
//                print("Error with updating isDone property of Item: \(error)")
//            }
        viewModel.isToggled(index: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    //    viewModel.saveItems()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
            viewModel.deleteItem(atRow: indexPath.row)
            tableView.reloadData()
        }
    }
}


//MARK: - Search bar methods
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }

        viewModel.filterItems(with: searchText)
        tableView.reloadData()
    }
}

