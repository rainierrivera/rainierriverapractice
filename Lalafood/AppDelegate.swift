//
//  AppDelegate.swift
//  Lalafood
//
//  Created by Rainier Rivera on 9/7/20.
//  Copyright © 2020 Rainier Rivera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
  
    let viewController = ViewController()
    viewController.viewModel = DeliveryListViewModel(deliveryPersistentService: DeliveryPersistentService(), webService: DeliveryWebservice())
    let navigationController = UINavigationController(rootViewController: viewController)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    return true
  }

}

