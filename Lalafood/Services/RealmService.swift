//
//  RealmService.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import RealmSwift

class RealmService {

  func object<T: Object, KeyType>(forPrimaryKey key: KeyType) throws -> T? {
    try perform("Fetching \(T.self)") { realm -> T? in
      let object = realm.object(ofType: T.self, forPrimaryKey: key)
      return object
    }
  }
  
  func objects<T: Object>() throws -> Results<T> {
    try perform("Fetching \(T.self)") { realm -> Results<T> in
      let objects = realm.objects(T.self)
      return objects
    }
  }

  func save<T: Object>(object: T, update: Realm.UpdatePolicy = .all) throws {
    try perform("Saving \(T.self)") { realm in
      try realm.write {
        realm.add(object, update: update)
      }
    }
  }

  func save<T: Object>(objects: [T], update: Realm.UpdatePolicy = .all) throws {
    try perform("Saving \(T.self)") { realm in
      try realm.write {
        realm.add(objects, update: update)
      }
    }
  }

  func delete<T: Object>(object: T) throws {
    try perform("Deleting \(T.self)") { realm in
      try realm.write {
        realm.delete(object)
      }
    }
  }

  func delete<T: Object>(objects: [T]) throws {
    try perform("Deleting \(T.self)") { realm in
      try realm.write {
        realm.delete(objects)
      }
    }
  }

  func deleteAll() throws {
    try perform("Deleting all data") { realm in
      try realm.write {
        realm.deleteAll()
      }
    }
  }

  func perform<T>(_ actionDebugName: String? = nil, action: (Realm) throws -> T) throws -> T {
    do {
      let realm = try Realm(configuration: Self.realmConfiguration)
      return try action(realm)
    } catch {
      throw error
    }
  }

  private static let realmConfiguration: Realm.Configuration = {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("default.realm")
    return .init(fileURL: fileURL, deleteRealmIfMigrationNeeded: true)
  }()

}

