//
//  HomeViewModel.swift
//  Todoey
//
//  Created by Maryna Bolotska on 11/04/24.
//

import UIKit

class ItemViewModel {
    var items: [Item] = []

    init() {
        // Populate items (for demonstration purposes)
        items = [Item(name: "Find Milk"), Item(name: "Buy bread"), Item(name: "Study iOS")]
    }
}
