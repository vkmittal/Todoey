//
//  Data.swift
//  Todoey
//
//  Created by Vikkas Miittal on 10/04/18.
//  Copyright © 2018 SolutionInfotech. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object{
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}
