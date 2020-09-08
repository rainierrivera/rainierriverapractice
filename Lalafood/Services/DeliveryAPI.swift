//
//  DeliveryAPI.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

import Moya

struct API {
  static let baseURL = "https://mock-api-mobile.dev.lalamove.com"
}


struct DeliveryParameter: Encodable {
  var offset: Int
  var limit: Int = 20
}

enum DeliveryAPI {
  case delivery(parameter: DeliveryParameter)
}

extension DeliveryAPI: TargetType {
  
  var baseURL: URL {
    URL(string: API.baseURL)!
  }
  
  var path: String {
    switch self {
    case .delivery:
      return "/v2/deliveries"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .delivery:
      return .get
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    return Data()
  }

  var task: Task {
     switch self {
     case .delivery:
       return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
     }
   }
  
  private var parameters: [String: Any] {
    switch self {
    case let .delivery(parameter):
      return (try? parameter.asDictionary()) ?? [:]
    }
  }
}




extension Encodable {

  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }

}
