//
//  DeliveryPersistentService.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

protocol DeliveryPersistentServiceType {
  func getDeliveries() throws -> [Delivery]
  func saveDeliveries(_ deliveries: [Delivery]) throws
  func favouriteDelivery(_ delivery: Delivery, isFavourite: Bool) throws
  func getFavourites() throws -> [FavouriteDelivery]
  func savePage(page: Page) throws
  func getPage() throws -> Page?
}

class DeliveryPersistentService: RealmService, DeliveryPersistentServiceType {
  
  func getDeliveries() throws -> [Delivery] {
    let deliveries: Results<Delivery> = try objects()
    return Array(deliveries)
  }
  
  func saveDeliveries(_ deliveries: [Delivery]) throws {
    try save(objects: deliveries)
  }
  
  func favouriteDelivery(_ delivery: Delivery, isFavourite: Bool) throws {
    let favouriteDelivery = FavouriteDelivery()
    favouriteDelivery.deliveryId = delivery.id
    favouriteDelivery.isFavourite = isFavourite
    try save(object: favouriteDelivery)
  }
  
  func getFavourites() throws -> [FavouriteDelivery] {
    let deliveries: Results<FavouriteDelivery> = try objects()
    return Array(deliveries)
  }
  
  func getPage() throws -> Page? {
    let page: Results<Page> = try objects()
    return Array(page).first
  }
  
  func savePage(page: Page) throws {
    try save(object: page)
  }
}

// Use for unit testing
class DeliveryMockPersistentService: RealmService, DeliveryPersistentServiceType {
  
  func getDeliveries() throws -> [Delivery] {
    // TODO: Should Use factory if time permits
    return []
  }
  
  func saveDeliveries(_ deliveries: [Delivery]) throws {
    try mockSave()
  }
  
  func favouriteDelivery(_ delivery: Delivery, isFavourite: Bool) throws {
    try mockSave()
  }
  
  func getFavourites() throws -> [FavouriteDelivery] {
    // TODO: Should Use factory if time permits
    return []
  }
  
  private func mockSave() throws {
    // TODO: MOck success save and fail
  }
  
  func getPage() throws -> Page? {
    return Page()
  }
  
  func savePage(page: Page) throws {
    try mockSave()
  }
}
