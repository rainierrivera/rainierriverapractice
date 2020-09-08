//
//  DeliveryImageCellViewModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

protocol DeliveryImageCellViewModelType {
  var imageURL: URL? { get }
}

class DeliveryImageCellViewModel: DeliveryImageCellViewModelType {
  init(delivery: Delivery) {
    self.delivery = delivery
  }
  
  var imageURL: URL? {
    URL(string: delivery.goodsPicture)
  }
  
  private let delivery: Delivery
}
