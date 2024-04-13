//
//  RealmData.swift
//  Todoey
//
//  Created by Maryna Bolotska on 13/04/24.
//

import Foundation

import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var date: Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
    @objc dynamic var cellColour: String = ""
}
