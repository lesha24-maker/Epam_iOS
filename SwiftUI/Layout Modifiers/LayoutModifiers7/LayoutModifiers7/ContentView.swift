//
//  ContentView.swift
//  LayoutModifiers7
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome")
                    .font(.largeTitle)
                
                NavigationLink("Go to Detail View") {
                    DetailView()
                }
                .font(.headline)
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
