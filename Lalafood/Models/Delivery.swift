//
//  Delivery.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

class Delivery: Object, Decodable {
  @objc dynamic var id: String = ""
  @objc dynamic var remarks: String = ""
  @objc dynamic var pickupTime: String = ""
  @objc dynamic var goodsPicture: String = ""
  @objc dynamic var deliveryFee: String = ""
  @objc dynamic var surcharge: String = ""
  @objc dynamic var route: Route?
  @objc dynamic var sender: Sender?
  var isFavourite: Bool = false
  var currentPage = 0
  
  private enum CodingKeys: String, CodingKey {
    case id
    case remarks
    case pickupTime
    case goodsPicture
    case deliveryFee
    case surcharge
    case route
    case sender
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  var date: Date {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: pickupTime)
    return date ?? Date()
  }
  
  
}


class Page: Object {
  @objc dynamic var currentPage: Int = 0
  @objc dynamic var maxPage: Int = 129
  
  override class func primaryKey() -> String? {
    return "maxPage"
  }
}
