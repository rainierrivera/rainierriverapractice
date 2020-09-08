//
//  ViewController.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var viewModel: DeliveryListViewModelType!
  
  private let tableView: UITableView =  {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let refreshControl: UIRefreshControl =  {
    var refreshControl = UIRefreshControl()
    return refreshControl
  }()
  
  // MARK: Overrides
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if isInitialLoad == false {
      viewModel.refresh()
    }
    isInitialLoad = false
  }
  
  // MARK: Privates
  
  private var isInitialLoad = true
  
  private func configureViews() {
    view.backgroundColor = .white
    
    viewModel.delegate = self
    viewModel.getLocalDeliveries()
    
    tableView.refreshControl = refreshControl
    refreshControl.manualRefresh()
    refreshControl.addTarget(self, action: #selector(hardRefresh(_:)), for: .valueChanged)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.register(BasicDeliveryTableViewCell.self, forCellReuseIdentifier: BasicDeliveryTableViewCell.identifier)
    
    navigationItem.title = viewModel.navigationTitle
  }
  
  private func setupConstraint() {
    view.addSubview(tableView)
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
  }
  
  @objc private func hardRefresh(_ sender: AnyObject) {
    let offset: CGFloat = 12.0
    tableView.contentInset = UIEdgeInsets(top: offset, left: 0, bottom: 0, right: 0)
    viewModel.getDeliveriesWebService(page: 0)
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSection
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemModel = viewModel.itemModels[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: itemModel.reuseIdentifier, for: indexPath)
    if let cell = cell as? DeliveryModelBindableType {
      cell.bindItemModel(to: itemModel)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return BasicDeliveryTableViewCell.preferredHeight
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.itemModels.count - 1 {
      viewModel.loadOtherDeliveriesWebService()
    }
  }
  
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.onSelectItem(at: indexPath)
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

extension ViewController: DeliveryListViewModelDelegate {
  func deliveryListViewModel(_ viewModel: DeliveryListViewModelType, didUpdateItemModel itemModel: [DeliverySectionItemModel]) {
    refreshControl.endRefreshing()
    tableView.contentInset = UIEdgeInsets(top: .zero, left: 0, bottom: 0, right: 0)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func deliveryListViewModel(_ viewModel: DeliveryListViewModelType, shouldPushController viewController: UIViewController) {
    navigationController?.pushViewController(viewController, animated: true)
  }
  
}
