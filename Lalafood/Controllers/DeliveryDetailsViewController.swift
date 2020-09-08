//
//  DeliveryDetailsViewController.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

class DeliveryDetailsViewController: UIViewController {
  
  private let tableView: UITableView =  {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  private let favouriteButton: UIButton =  {
    let button = UIButton(type: .system)
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  var viewModel: DeliveryDetailsViewModelType!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViews()
    setupConstraint()
  }
  
  // MARK: Privates
  
  @objc private func buttonAction(_ sender: AnyObject) {
    viewModel.favouriteDelivery(isFavourite: !viewModel.isFavourite)
    navigationController?.popViewController(animated: true)
  }
  
  private func configureViews() {
    view.backgroundColor = .white
    
    viewModel.delegate = self
    
    favouriteButton.setTitle(viewModel.favouriteButtonText, for: .normal)
    
    tableView.dataSource = self
    
    
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    tableView.register(DeliveryInformationTableViewCell.self, forCellReuseIdentifier: DeliveryInformationTableViewCell.identifier)
    tableView.register(DeliveryImageTableViewCell.self, forCellReuseIdentifier: DeliveryImageTableViewCell.identifier)
    tableView.register(DeliveryFeeTableViewCell.self, forCellReuseIdentifier: DeliveryFeeTableViewCell.identifier)
  }
  
  private func setupConstraint() {
    view.addSubview(tableView)
    view.addSubview(favouriteButton)
    
    favouriteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
    favouriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    favouriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
    favouriteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    tableView.bottomAnchor.constraint(equalTo: favouriteButton.bottomAnchor, constant: -8).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

  }

}

extension DeliveryDetailsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let itemModel = viewModel.itemModels[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: itemModel.reuseIdentifier, for: indexPath)
    if let cell = cell as? DeliveryDetailsModelBindableType {
      cell.bindItemModel(to: itemModel)
    }
    return cell
  }
}

extension DeliveryDetailsViewController: DeliveryDetailsViewModelDelegate {
  func deliveryDetailsViewModel(_ viewModel: DeliveryDetailsViewModelType, didUpdateSectionModel itemModels: [DeliveryDetailSectionItemModel]) {
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
