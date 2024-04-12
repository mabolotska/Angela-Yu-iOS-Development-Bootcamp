//
//  HomeViewModel.swift
//  Todoey
//
//  Created by Maryna Bolotska on 11/04/24.
//

import UIKit

class ItemViewModel {
    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

  //  var items: [Item] = []
    var items = [Item]()
    init() {
        // Populate items (for demonstration purposes)
   
    }

    func saveItems() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
   //     self.tableView.reloadData()
    }

    func loadItems() {
        guard let data = try? Data(contentsOf: dataFilePath!) else { return }
            let decoder = PropertyListDecoder()
            do {
                items = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
    }
}
