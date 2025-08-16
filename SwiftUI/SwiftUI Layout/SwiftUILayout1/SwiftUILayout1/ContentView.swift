//
//  ContentView.swift
//  SwiftUILayout1
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGreeting = false

    var body: some View {
        VStack {
            Toggle("Show Greeting", isOn: $showGreeting)
                .padding()

            if showGreeting {
                Text("Hello, SwiftUI!")
                    .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
