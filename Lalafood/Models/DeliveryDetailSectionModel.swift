//
//  DeliveryDetailSectionModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

struct DeliveryDetailSectionModel {
  var items: [DeliveryDetailSectionItemModel]
}

enum DeliveryDetailSectionItemModel {
  case information(viewModel: DeliveryInformationCellViewModelType)
  case image(viewModel: DeliveryImageCellViewModelType)
  case deliveryFee(viewModel: DeliveryFeeCellViewModelType)
}

extension DeliveryDetailSectionItemModel {
  var reuseIdentifier: String {
    switch self {
    case .information:
      return DeliveryInformationTableViewCell.identifier
    case .image:
      return DeliveryImageTableViewCell.identifier
    case .deliveryFee:
      return DeliveryFeeTableViewCell.identifier
    }
  }
  
  func viewModel<T>() -> T {
    switch self {
    case let .information(viewModel):
      return viewModel as! T
    case let .image(viewModel):
      return viewModel as! T
    case let .deliveryFee(viewModel):
      return viewModel as! T
    }
  }
}

// MARK: - DeliveryModelBindableType

protocol DeliveryDetailsModelBindableType {
  func bindItemModel(to itemModel: DeliveryDetailSectionItemModel)
}
