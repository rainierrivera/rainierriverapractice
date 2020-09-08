//
//  DeliveryInformationCellViewModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

protocol DeliveryInformationCellViewModelType {
  var deliveryTo: String { get }
  var deliveryFrom: String { get }
}

class DeliveryInformationCellViewModel: DeliveryInformationCellViewModelType {
  init(delivery: Delivery) {
    self.delivery = delivery
  }
  
  var deliveryFrom: String {
    delivery.sender?.name ?? " "
  }
  
  var deliveryTo: String {
    delivery.route?.end ?? " "
  }
  
  private let delivery: Delivery
}
