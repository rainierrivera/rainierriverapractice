//
//  Route.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

class Route: Object, Decodable {
  @objc dynamic var start: String = ""
  @objc dynamic var end: String = ""
}
