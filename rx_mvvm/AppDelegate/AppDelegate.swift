//
//  AppDelegate.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 19.10.2021.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupServices()
        
        return true
    }

    private func setupServices() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        
        Reachability.shared.startListening()
    }
}

