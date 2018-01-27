//
//  Category.swift
//  Todoey
//
//  Created by Sam Jensen on 1/26/18.
//  Copyright © 2018 SamJensen. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
