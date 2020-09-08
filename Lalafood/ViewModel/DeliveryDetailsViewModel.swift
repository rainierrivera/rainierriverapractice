//
//  DeliveryDetailsViewModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation

protocol DeliveryDetailsViewModelDelegate: class {
  func deliveryDetailsViewModel(_ viewModel: DeliveryDetailsViewModelType, didUpdateSectionModel itemModels: [DeliveryDetailSectionItemModel])
}

protocol DeliveryDetailsViewModelType {
  var numberOfRows: Int { get }
  var numberOfSections: Int { get }
  var itemModels: [DeliveryDetailSectionItemModel] { get }
  var favouriteButtonText: String { get }
  var isFavourite: Bool { get }
  
  var delegate: DeliveryDetailsViewModelDelegate? { get set }
  
  func favouriteDelivery(isFavourite: Bool)
}

class DeliveryDetailsViewModel: DeliveryDetailsViewModelType {
  
  init(delivery: Delivery, deliveryPersistentService: DeliveryPersistentServiceType) {
    self.delivery = delivery
    self.deliveryPersistentService = deliveryPersistentService
    updateSectionModels()
  }
  
  weak var delegate: DeliveryDetailsViewModelDelegate?
  
  var numberOfRows: Int {
    itemModels.count
  }
  
  var numberOfSections: Int {
    1
  }
  
  var itemModels = [DeliveryDetailSectionItemModel]() {
    didSet {
      delegate?.deliveryDetailsViewModel(self, didUpdateSectionModel: itemModels)
    }
  }
  
  func favouriteDelivery(isFavourite: Bool) {
    do {
      try deliveryPersistentService.favouriteDelivery(delivery, isFavourite: isFavourite)
    } catch {
      print("unable to save fave dlivery")
    }
  }
  
  var favouriteButtonText: String {
    delivery.isFavourite ? "Unfavourite" : "Add to Favourite ❤️"
  }
  
  var isFavourite: Bool {
    delivery.isFavourite
  }
  
  // MARK: Privates
  
  private let delivery: Delivery
  private let deliveryPersistentService: DeliveryPersistentServiceType
  
  private func updateSectionModels() {
    itemModels = []
    
    let informationViewModel = DeliveryInformationCellViewModel(delivery: delivery)
    itemModels.append(.information(viewModel: informationViewModel))
    
    
    let imageViewModel = DeliveryImageCellViewModel(delivery: delivery)
    itemModels.append(.image(viewModel: imageViewModel))
    
    let feeViewModel = DeliveryFeeCellViewModel(delivery: delivery)
    itemModels.append(.deliveryFee(viewModel: feeViewModel))
  }
}
