//
//  AppLifecycleMonitor.swift
//  Notifications3
//
//  Created by Alexey Lim on 22/7/25.
//

import UIKit

final class AppLifecycleMonitor {

    static let shared = AppLifecycleMonitor()

    private init() {
        setupObservers()
    }
    
    deinit {
        removeObservers()
        print("AppLifecycleMonitor deinitialized and observers removed.")
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        print("AppLifecycleMonitor observers have been set up.")
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func appDidEnterBackground() {
        print("App did enter background at \(Date().formatted(date: .omitted, time: .standard))")
    }
    
    @objc private func appWillEnterForeground() {
        print("App will enter foreground at \(Date().formatted(date: .omitted, time: .standard))")
    }
}
