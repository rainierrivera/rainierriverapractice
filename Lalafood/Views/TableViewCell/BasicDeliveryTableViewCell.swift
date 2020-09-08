//
//  BasicDeliveryTableViewCell.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit
import AlamofireImage

protocol BasicDeliveryCellViewModelType {
  var toText: String { get }
  var fromText: String { get }
  var imageURL: URL? { get }
  
  var isFavourite: Bool { get }
  var deliveryFee: String { get }
}

class BasicDeliveryCellViewModel: BasicDeliveryCellViewModelType {
  init(delivery: Delivery) {
    self.delivery = delivery
  }
  
  var isFavourite: Bool {
    delivery.isFavourite
  }
  
  var fromText: String {
    "From: \(delivery.sender?.name ?? "")"
  }
  
  var toText: String {
    "To: \(delivery.route?.end ?? "")"
  }
  
  var imageURL: URL? {
    URL(string: delivery.goodsPicture)
  }
  
  var deliveryFee: String {
    let deliveryFee = Double(delivery.deliveryFee.filter("0123456789.".contains))! // Much better to have extension
    let surchargeFee = Double(delivery.surcharge.filter("0123456789.".contains))!
    let result = (deliveryFee + surchargeFee).roundToDecimal()
    return "$\(result)"
  }
  
  private let delivery: Delivery
}

class BasicDeliveryTableViewCell: UITableViewCell {

  static let identifier = "deliveryCell"
  static let preferredHeight: CGFloat = 108
  
  var containerView: UIView = {
    let view = UIView()
    view.clipsToBounds = false
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  var deliveryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  var fromLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var toLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var priceLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var favouriteLabel: UILabel = {
    let label = UILabel()
    label.font = label.font.withSize(14)
    label.text = "❤️"
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var viewModel: BasicDeliveryCellViewModelType! {
    didSet {
      bindViewModel()
    }
  }
  
  func bindViewModel() {
    toLabel.text = viewModel.toText
    fromLabel.text = viewModel.fromText
    priceLabel.text = viewModel.deliveryFee
    deliveryImageView.image = nil
    
    favouriteLabel.isHidden = !viewModel.isFavourite
    if let url = viewModel.imageURL {
      deliveryImageView.af.setImage(withURL: url,
                                    imageTransition: .crossDissolve(0.2)
      )
    }
    
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    containerView.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
    addSubview(containerView)
    containerView.addSubview(favouriteLabel)
    
    containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
    containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true

    containerView.addSubview(deliveryImageView)
    deliveryImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
    deliveryImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
    deliveryImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
    deliveryImageView.widthAnchor.constraint(equalToConstant: 77).isActive = true

    containerView.addSubview(fromLabel)
    fromLabel.leftAnchor.constraint(equalTo: deliveryImageView.rightAnchor, constant: 16).isActive = true
    fromLabel.rightAnchor.constraint(equalTo: favouriteLabel.rightAnchor, constant: -8).isActive = true
    fromLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -10).isActive = true
    
    containerView.addSubview(toLabel)
    toLabel.leftAnchor.constraint(equalTo: deliveryImageView.rightAnchor, constant: 16).isActive = true
    toLabel.topAnchor.constraint(equalTo: fromLabel.bottomAnchor, constant: 8).isActive = true
    
    containerView.addSubview(priceLabel)
    priceLabel.leftAnchor.constraint(equalTo: toLabel.rightAnchor, constant: 16).isActive = true
    priceLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
    priceLabel.topAnchor.constraint(equalTo: toLabel.topAnchor, constant: 0).isActive = true
    
    favouriteLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
    favouriteLabel.topAnchor.constraint(equalTo: fromLabel.topAnchor, constant: 0).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension BasicDeliveryTableViewCell: DeliveryModelBindableType {
  func bindItemModel(to itemModel: DeliverySectionItemModel) {
    self.viewModel = itemModel.viewModel()
  }
}
