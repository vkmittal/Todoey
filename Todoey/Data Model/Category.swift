//
//  Category.swift
//  Todoey
//
//  Created by Vikkas Miittal on 10/04/18.
//  Copyright © 2018 SolutionInfotech. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
