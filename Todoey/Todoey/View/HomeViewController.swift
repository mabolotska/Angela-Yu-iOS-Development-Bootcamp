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
        // set navbar color in appdelegate
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
        return viewModel.items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else { return UITableViewCell() }
        guard let item = viewModel.items?[indexPath.row] else { return cell }
        cell.set(model: item)
        guard let isDone = viewModel.items?[indexPath.row].isDone else { return cell}
        cell.accessoryType = isDone ? .checkmark : .none
     //   cell.accessoryType = viewModel.items?[indexPath.row].isDone ? .checkmark : .none
         tableView.deselectRow(at: indexPath, animated: true)
  //      cell.accessoryType = item.done ? .checkmark : .none
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
}


//MARK: - Search bar methods

extension HomeViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        viewModel.loadItems(with: request, predicate: predicate)

    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.isEmpty != nil {
//            viewModel.loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text! == "" {
//            viewModel.loadItems()
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//        else {
//            viewModel.items = viewModel.items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
//            tableView.reloadData()
//        }
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.loadItems() // Reload all items
        } else {
            viewModel.filterItems(with: searchText)
        }
        tableView.reloadData()
    }
}

