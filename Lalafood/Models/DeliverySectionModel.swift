//
//  DeliverySectionModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

struct DeliverySectionModel {
  var items: [DeliverySectionItemModel]
}

enum DeliverySectionItemModel {
  case basic(viewModel: BasicDeliveryCellViewModelType)
}

extension DeliverySectionItemModel {
  var reuseIdentifier: String {
    switch self {
    case .basic:
      return "deliveryCell"
    }
  }
    
  func viewModel<T>() -> T {
    switch self {
    case let .basic(viewModel):
      return viewModel as! T
    }
  }
}

// MARK: - DeliveryModelBindableType

protocol DeliveryModelBindableType {
  func bindItemModel(to itemModel: DeliverySectionItemModel)
}
