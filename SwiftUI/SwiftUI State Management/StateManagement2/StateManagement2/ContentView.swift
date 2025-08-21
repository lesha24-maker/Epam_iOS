//
//  ContentView.swift
//  StateManagement2
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGreeting = false

    var body: some View {
        VStack(spacing: 20) {
            
            Toggle("Show Greeting", isOn: $showGreeting.animation())
            
            if showGreeting {
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
