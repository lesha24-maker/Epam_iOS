//
//  MyUIKitViewRepresentable.swift
//  EnvironmentObjects4
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI
import UIKit

struct MyUIKitViewRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MyUIKitViewController {
        return MyUIKitViewController()
    }
    
    func updateUIViewController(_ uiViewController: MyUIKitViewController, context: Context) {
    }
}
