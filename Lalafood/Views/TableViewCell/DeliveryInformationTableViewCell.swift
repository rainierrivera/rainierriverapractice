//
//  DeliveryInformationTableViewCell.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

class DeliveryInformationTableViewCell: UITableViewCell {

  static let identifier = "deliveryInformationCell"
  
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let toLabel: UILabel = {
    let label = UILabel()
    label.text = "To:"
    label.textAlignment = .left
    label.font = label.font.withSize(12)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let toValueLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(12)
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let fromLabel: UILabel = {
    let label = UILabel()
    label.text = "From:"
    label.font = label.font.withSize(12)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let fromValueLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(12)
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  var viewModel: DeliveryInformationCellViewModelType! {
    didSet {
      bindViewModel()
    }
  }

  func bindViewModel() {
    toValueLabel.text = viewModel.deliveryTo
    fromValueLabel.text = viewModel.deliveryFrom
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupConstraints()
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    containerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1) // Much better to have color extension
    
    addSubview(containerView)
    containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    containerView.addSubview(toValueLabel)
    toValueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -12).isActive = true
    toValueLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
    
    containerView.addSubview(toLabel)
    toLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -12).isActive = true
    toLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    
    containerView.addSubview(fromLabel)
    fromLabel.topAnchor.constraint(equalTo: toLabel.bottomAnchor, constant: 8).isActive = true
    fromLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    
    containerView.addSubview(fromValueLabel)
    fromValueLabel.topAnchor.constraint(equalTo: toValueLabel.bottomAnchor, constant: 8).isActive = true
    fromValueLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
  }
}

extension DeliveryInformationTableViewCell: DeliveryDetailsModelBindableType {
  func bindItemModel(to itemModel: DeliveryDetailSectionItemModel) {
    self.viewModel = itemModel.viewModel()
  }
}
