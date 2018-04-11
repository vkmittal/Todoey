//
//  Item.swift
//  Todoey
//
//  Created by Vikkas Miittal on 10/04/18.
//  Copyright © 2018 SolutionInfotech. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
