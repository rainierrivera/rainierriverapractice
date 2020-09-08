//
//  DeliveryFeeTableViewCell.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

class DeliveryFeeTableViewCell: UITableViewCell {

  static let identifier = "deliveryFeeCell"
  
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let deliveryFeeLabel: UILabel = {
    let label = UILabel()
    label.text = "DeliveryFee"
    label.font = label.font.withSize(14)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let deliveryFeeValueLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var viewModel: DeliveryFeeCellViewModelType! {
    didSet {
      bindViewModel()
    }
  }
  
  func bindViewModel() {
    deliveryFeeValueLabel.text = viewModel.deliveryFee
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    containerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
  
    // Much better if no magic numbers, but due to time constraint, will leave it there
    addSubview(containerView)
    containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    containerView.addSubview(deliveryFeeLabel)
    deliveryFeeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
    deliveryFeeLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    
    containerView.addSubview(deliveryFeeValueLabel)
    deliveryFeeValueLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
    deliveryFeeValueLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DeliveryFeeTableViewCell: DeliveryDetailsModelBindableType {
  func bindItemModel(to itemModel: DeliveryDetailSectionItemModel) {
    self.viewModel = itemModel.viewModel()
  }
}
