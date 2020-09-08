//
//  NetworkService.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Moya

typealias RequestSuccessClosure<T> = (_ result: T?) -> ()
typealias RequestFailureClosure = (_ error: WebServiceError?) -> ()

protocol WebServiceType {

  associatedtype Provider
  func requestObject<T: Decodable>(path: Provider, success: RequestSuccessClosure<T>?, failure: RequestFailureClosure?)

}

struct WebService<U: TargetType>: WebServiceType {

  private let provider: MoyaProvider<U>

  init(provider: MoyaProvider<U> = MoyaProvider<U>()) {
    self.provider = provider
  }

  func requestObject<T: Decodable>(path: U, success: RequestSuccessClosure<T>?, failure: RequestFailureClosure?) {
    self.provider.request(path) { result in
      switch result {
      case let .success(response):
        do {
          let object = try JSONDecoder().decode(T.self, from: response.data)
          success?(object)
        } catch {
          do {
            let object = try JSONDecoder().decode(APIErrorResponse.self, from: response.data)
            failure?(WebServiceError.api(object))
          } catch {
            failure?(WebServiceError.mapping)
          }
        }
      case let .failure(error):
        failure?(WebServiceError.moya(error))
      }
    }
  }

}
