//
//  ViewController.swift
//  Controllers
//
//  Created by Alexey Lim on 19/6/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
        setupTabs()
        setupAppearance()
    }
    
    private func setupTabs() {
        let onboardingNav = UINavigationController(rootViewController: OnboardingViewController())
        let profileNav = UINavigationController(rootViewController: ProfileViewController())
        let settingsNav = UINavigationController(rootViewController: SettingsViewController())

        onboardingNav.tabBarItem = UITabBarItem(title: "Onboarding", image: UIImage(systemName: "person.circle"), tag: 0)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        settingsNav.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 2)

        self.setViewControllers([onboardingNav, profileNav, settingsNav], animated: true)
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemOrange

        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.isTranslucent = false
    }
}

