//
//  DeliveryWebService.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

protocol DeliveryWebServiceType {
  func getDeliveries(parameter: DeliveryParameter,
                     success: RequestSuccessClosure<[Delivery]>?,
                     failure: RequestFailureClosure?)
}

struct DeliveryWebservice: DeliveryWebServiceType {
  
  private let service: WebService<DeliveryAPI>
  
  init(service: WebService<DeliveryAPI> = .init()) {
    self.service = service
  }
  
  func getDeliveries(parameter: DeliveryParameter, success: RequestSuccessClosure<[Delivery]>?, failure: RequestFailureClosure?) {
    service.requestObject(path: .delivery(parameter: parameter),
                          success: success,
                          failure: failure)
  }
  
}
