//
//  ContentView.swift
//  SwiftUILayout6
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [ListItem] = [
        ListItem(name: "Milk", isToggled: false),
        ListItem(name: "Eggs", isToggled: true),
        ListItem(name: "Bread", isToggled: false),
        ListItem(name: "Apples", isToggled: true),
        ListItem(name: "Chicken", isToggled: false)
    ]

    var body: some View {
        NavigationView {
            List($items) { $item in
                Toggle(item.name, isOn: $item.isToggled)
            }
            .navigationTitle("Grocery List")
        }
    }
}

#Preview {
    ContentView()
}
