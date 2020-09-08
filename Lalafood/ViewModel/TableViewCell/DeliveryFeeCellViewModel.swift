//
//  DeliveryFeeCellViewModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

protocol DeliveryFeeCellViewModelType {
  var deliveryFee: String { get }
}

class DeliveryFeeCellViewModel: DeliveryFeeCellViewModelType {
  init(delivery: Delivery) {
    self.delivery = delivery
  }
  
  var deliveryFee: String {
    let deliveryFee = Double(delivery.deliveryFee.filter("0123456789.".contains))! // Much better to have extension and not to force unwrap this
    let surchargeFee = Double(delivery.surcharge.filter("0123456789.".contains))!
    let result = (deliveryFee + surchargeFee).roundToDecimal()
    return "$\(result)"
  }
  
  private let delivery: Delivery
}
