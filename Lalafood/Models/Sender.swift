//
//  Sender.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

class Sender: Object, Decodable {
  @objc dynamic var phone: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var email: String = ""
}
