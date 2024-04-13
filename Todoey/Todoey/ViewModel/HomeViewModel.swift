//
//  HomeViewModel.swift
//  Todoey
//
//  Created by Maryna Bolotska on 11/04/24.
//

import UIKit
import CoreData
import RealmSwift

class ItemViewModel {
    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var onDataUpdate: (() -> Void)?
    var realm: Realm!
    var items: Results<Item>?
    init() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
    }
    var selectedCategory: Category? {
        didSet{
            loadItems()
        }
    }

 //   var items = [Item]() //core database


    func saveItems() {
        do {
          try context.save()
        } catch {
           print("Error saving context \(error)")
        }
        onDataUpdate?()
   //     self.tableView.reloadData()

    }

//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let addtionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//
//        do {
//            items = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context \(error)")
//        }
//        onDataUpdate?()
//     //   tableView.reloadData()
//
//    }
    func loadItems() {
        items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        onDataUpdate?()
    }
//for core data
//    func addItems(text: UITextField) {
//        let newItem = Item(context: self.context)
//        newItem.name = text.text
//        newItem.done = false
//        newItem.parentCategory = self.selectedCategory
//        items.append(newItem)
//    }

    func addItems(text: UITextField) {
        if let currentCategory = self.selectedCategory {
            do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = text.text ?? "no title"
                    currentCategory.items.append(newItem)
                }
            } catch {
                print("Error with saving new item: \(error)")
            }
            onDataUpdate?()
        }
    }

    func deleteItem(atRow: Int) {
        if let item = self.items?[atRow] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print("Error with deleting category: \(error)")
            }
        }
    }

    func isToggled(index: IndexPath) {
        if let item = items?[index.row] {
            do {
                try realm.write {
                    item.isDone = !item.isDone
                }
            } catch {
                print("Error with updating isDone property of Item: \(error)")
            }
        }
    }

    func filterItems(with searchText: String) {
        items = realm.objects(Item.self).filter("title CONTAINS[cd] %@", searchText).sorted(byKeyPath: "date", ascending: true)
    }
}
