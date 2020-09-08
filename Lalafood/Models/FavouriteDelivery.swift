//
//  FavouriteDelivery.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

class FavouriteDelivery: Object {
  @objc dynamic var isFavourite: Bool = false
  @objc dynamic var deliveryId: String = ""
  
  override class func primaryKey() -> String? {
    return "deliveryId"
  }
}
