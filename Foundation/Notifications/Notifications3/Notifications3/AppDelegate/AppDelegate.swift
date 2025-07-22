//
//  AppDelegate.swift
//  Notifications3
//
//  Created by Alexey Lim on 22/7/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let lifecycleMonitor = AppLifecycleMonitor.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
