//
//  ContentView.swift
//  StateManagement1
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Counter: \(counter)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button("+1") {
                counter += 1
            }
            .font(.title)
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
