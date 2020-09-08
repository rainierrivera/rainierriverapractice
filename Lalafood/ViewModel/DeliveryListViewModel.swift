//
//  DeliveryListViewModel.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import Foundation
import UIKit

protocol DeliveryListViewModelDelegate: class {
  func deliveryListViewModel(_ viewModel: DeliveryListViewModelType, didUpdateItemModel itemModel: [DeliverySectionItemModel])
  func deliveryListViewModel(_ viewModel: DeliveryListViewModelType, shouldPushController viewController: UIViewController)
}

protocol DeliveryListViewModelType {
  var navigationTitle: String { get }
  
  var numberOfRows: Int { get }
  var numberOfSection: Int { get }
  var itemModels: [DeliverySectionItemModel] { get }
  
  var delegate: DeliveryListViewModelDelegate? { get set }
  
  func getLocalDeliveries()
  func getDeliveriesWebService(page: Int)
  func loadOtherDeliveriesWebService()
  func onSelectItem(at indexPath: IndexPath)
  func refresh()
}

class DeliveryListViewModel: DeliveryListViewModelType {
  
  // Inject service for it to make testable in the future
  init(deliveryPersistentService: DeliveryPersistentServiceType, webService: DeliveryWebServiceType) {
    self.deliveryPersistentService = deliveryPersistentService
    self.webService = webService
    page = Page()
    getDeliveriesWebService(page: 0)
    getFavouriteDelivery()
    
    getPage()
  }
  
  var itemModels = [DeliverySectionItemModel]()
  
  weak var delegate: DeliveryListViewModelDelegate?
  
  var navigationTitle: String {
    "My Deliveries"
  }
  
  var numberOfRows: Int {
    itemModels.count
  }
  
  var numberOfSection: Int {
    1
  }
  
  func refresh() {
    updateSectionModel(deliveries)
  }
  
  // for caching
  func getLocalDeliveries() {
    do {
      let deliveries = try deliveryPersistentService.getDeliveries()
      self.deliveries = deliveries
      self.updateSectionModel(deliveries)
    } catch {
      delegate?.deliveryListViewModel(self, didUpdateItemModel: [])
    }
  }
  
  func getDeliveriesWebService(page: Int) {
    guard isLoading == false else { return }
    isLoading = true
    let parameter = DeliveryParameter(offset: page) // default
    webService.getDeliveries(parameter: parameter, success: { [weak self] (deliveries) in
      guard let self = self, let deliveries = deliveries else { return }
      self.saveDeliveries(deliveries)
      self.isLoading = false
    }) { [weak self](error) in
      guard let self = self else { return }
      self.isLoading = false
      self.updateSectionModel(self.deliveries)
      print(error?.errorDescription ?? "")
    }
  }
  
  func onSelectItem(at indexPath: IndexPath) {
    let delivery = deliveries[indexPath.row]
    let viewModel = DeliveryDetailsViewModel(delivery: delivery, deliveryPersistentService: deliveryPersistentService)
    let viewController = DeliveryDetailsViewController()
    viewController.viewModel = viewModel
    delegate?.deliveryListViewModel(self, shouldPushController: viewController)
  }
  
  func loadOtherDeliveriesWebService() {
    guard isLoading == false, page.currentPage <= Constant.maxPage else { return }
    isLoading = true
    
    let nextPage = page.currentPage + 1
    let parameter = DeliveryParameter(offset: nextPage) // default
    webService.getDeliveries(parameter: parameter, success: { [weak self] (deliveries) in
      guard let self = self, let deliveries = deliveries else { return }
   
      self.savePage(currentPage: nextPage)
      self.saveDeliveries(deliveries)
      self.isLoading = false
    }) { [weak self](error) in
      guard let self = self else { return }
      self.isLoading = false
      self.updateSectionModel(self.deliveries)
      print(error?.errorDescription ?? "")
    }
  }
  
  // MARK: Privates
  
  private let webService: DeliveryWebServiceType
  private let deliveryPersistentService: DeliveryPersistentServiceType
  private var deliveries = [Delivery]()
  private var favourites = [FavouriteDelivery]()
  private var isLoading = false
  private var page: Page
  
  private struct Constant {
    static let maxPage: Int = 129
  }
  
  private func savePage(currentPage: Int) {
    do {
      let page = Page()
      page.currentPage = currentPage
      page.maxPage = Constant.maxPage
      try deliveryPersistentService.savePage(page: page)
      getPage()
    } catch {
      
    }
  }
  
  private func getPage() {
    do {
      let savedPage = try deliveryPersistentService.getPage()
      if let page = savedPage {
        self.page = page
      }
    } catch {
      
    }
  }
  
  private func saveDeliveries(_ deliveries: [Delivery]) {
    do {
      try deliveryPersistentService.saveDeliveries(deliveries)
      self.getLocalDeliveries()
    } catch {
      // unable to save deliveries
    }
  }
  
  private func updateSectionModel(_ deliveries: [Delivery]) {
    itemModels = []
    
    // sort date
    var _deliveries = deliveries
    _deliveries.sort {
      return $0.date.compare($1.date) == ComparisonResult.orderedDescending
    }
    _deliveries.forEach { (delivery) in
      self.favourites.forEach { (favourite) in
        if delivery.id == favourite.deliveryId {
          delivery.isFavourite = favourite.isFavourite
        }
      }

      let viewModel = BasicDeliveryCellViewModel(delivery: delivery)
      itemModels.append(.basic(viewModel: viewModel))
    }
    
    self.deliveries = _deliveries
    delegate?.deliveryListViewModel(self, didUpdateItemModel: itemModels)
  }
  
  private func getFavouriteDelivery() {
    do {
      favourites = try deliveryPersistentService.getFavourites()
    } catch {
      favourites = []
    }
  }
  
}
