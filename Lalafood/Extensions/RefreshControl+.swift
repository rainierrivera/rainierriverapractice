//
//  RefreshControl+.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/8/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

extension UIRefreshControl {
  func manualRefresh() {
    if let scrollView = superview as? UIScrollView {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
    }
    beginRefreshing()
  }
}
