//
//  AppDelegate.swift
//  AnimalManager
//
//  Created by BLU on 27/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let navigationController = window!.rootViewController as? UINavigationController,
            let animalListViewController = navigationController.topViewController as? AnimalListViewController {
            animalListViewController.viewModel = AnimalListViewModel()
        }
        return true
    }
}

