//
//  ContentView.swift
//  SwiftUILayout2
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ContentView: View {
    let names = ["Aleksei", "Dania", "Nikita", "Rita", "Maxim"]

    var body: some View {
        List(names, id: \.self) { name in
            HStack {
                Text(name)
                Spacer()
                Button("Tap") {
                    print("Button tapped for \(name)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
