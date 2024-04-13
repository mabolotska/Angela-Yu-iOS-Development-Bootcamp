//
//  CategoryViewModel.swift
//  Todoey
//
//  Created by Maryna Bolotska on 13/04/24.
//

import UIKit
import CoreData
import RealmSwift

class CategoryViewModel {
 //   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var onDataUpdate: (() -> Void)?
   // var categories = [Category]() we dont use CoreData anymore
    var realm: Realm!

      var categories: Results<Category>?

      init() {
          do {
              realm = try Realm()
          } catch {
              print("Error initializing Realm: \(error)")
          }
      }
//let realm = try! Realm() swiftLint does not like this declaration
    

//    func saveItems() { only for CoreData
//        do {
//          try context.save()
//        } catch {
//           print("Error saving context \(error)")
//        }
//        onDataUpdate?()
//
//    }
//    only for CoreData
//    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
//
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//            categories = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//        onDataUpdate?()
//    }

    func loadItems() {
        categories = realm.objects(Category.self)
        onDataUpdate?()
    }

    func addCategories(text: UITextField) {
        //        let newCategory = Category(context: self.context)
        //        newCategory.name = text.text
        //        categories.append(newCategory)
        do {
            try realm.write {
            let newCategory = Category()
            newCategory.name = text.text!

            self.realm.add(newCategory)
        }
    }catch {
            print("Error with saving new category: \(error)")
        }
        onDataUpdate?()
    }


    func deleteItem(atRow: Int) {
        if let category = self.categories?[atRow] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print("Error with deleting category: \(error)")
            }
        }
    }
}
