//
//  DeliveryImageTableViewCell.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit
import AlamofireImage

class DeliveryImageTableViewCell: UITableViewCell {

  static let identifier = "deliveryImageCell"
  var viewModel: DeliveryImageCellViewModelType! {
    didSet {
      bindViewModel()
    }
  }
  
  private let containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let goodsLabel: UILabel = {
    let label = UILabel()
    label.text = "Goods image: "
    label.font = label.font.withSize(14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let goodsImageView: UIImageView = {
    let goodsImageView = UIImageView()
    goodsImageView.contentMode = .scaleAspectFit
    goodsImageView.translatesAutoresizingMaskIntoConstraints = false
    return goodsImageView
  }()
  
  
  func bindViewModel() {
    
    if let url = viewModel.imageURL {
      goodsImageView.af.setImage(withURL: url,
                                 imageTransition: .crossDissolve(0.2)
      )
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    containerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    addSubview(containerView)
    containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
    containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
    containerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
    
    containerView.addSubview(goodsLabel)
    goodsLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    goodsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
    
    containerView.addSubview(goodsImageView)
    goodsImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
    goodsImageView.topAnchor.constraint(equalTo: goodsLabel.bottomAnchor, constant: 8).isActive = true
    goodsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
    goodsImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DeliveryImageTableViewCell: DeliveryDetailsModelBindableType {
  func bindItemModel(to itemModel: DeliveryDetailSectionItemModel) {
    self.viewModel = itemModel.viewModel()
  }
}
