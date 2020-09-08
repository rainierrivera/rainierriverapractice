//
//  WebServiceError.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

import Moya
import Alamofire

struct APIErrorResponse: Decodable {
  var code = 0
  var message: String?
}

enum WebServiceError: Error {
  case api(APIErrorResponse)
  case moya(MoyaError)
  case mapping
}

extension WebServiceError: LocalizedError {

  var code: Int {
    switch self {
    case let .api(error):
      return error.code
    case let .moya(error):
      switch error {
      case let .underlying(afError as AFError, _):
        return (afError.underlyingError as NSError?)?.code ?? -10000
      default:
        return error.response?.statusCode ?? -10000
      }
    case .mapping:
      return -10001
    }
  }

  var errorDescription: String? {
    switch self {
    case let .api(error):
      return error.message
    case let .moya(error):
      switch error {
       case let .underlying(afError as AFError, _):
        let code = (afError.underlyingError as NSError?)?.code ?? -10000
        if code == NSURLErrorNotConnectedToInternet {
          return "No Internet Connection. Please try again."
        } else {
          return "There seems to be a problem connecting to server. Please try again."
        }
       default:
         return error.errorDescription
       }
    default:
      return "Failed to map data to JSON."
    }
  }

}
