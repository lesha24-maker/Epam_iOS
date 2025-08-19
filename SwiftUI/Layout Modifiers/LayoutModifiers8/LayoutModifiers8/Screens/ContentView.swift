//
//  ContentView.swift
//  LayoutModifiers8
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
            
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .settings:
                    SettingsView(path: $path)
                case .profile:
                    ProfileView(path: $path)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
