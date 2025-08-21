//
//  ContentView.swift
//  StateManagement6
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var settings: [SettingItem] = [
        SettingItem(name: "Wi-Fi", isOn: true),
        SettingItem(name: "Bluetooth", isOn: false),
        SettingItem(name: "Notifications", isOn: true),
        SettingItem(name: "Dark Mode", isOn: false)
    ]

    var body: some View {
        NavigationStack {
            List($settings) { $setting in
                Toggle(setting.name, isOn: $setting.isOn)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
