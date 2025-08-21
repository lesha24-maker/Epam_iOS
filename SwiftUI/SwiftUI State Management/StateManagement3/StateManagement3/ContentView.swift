//
//  ContentView.swift
//  StateManagement3
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI

struct ChildView: View {
    @Binding var isParentToggleOn: Bool
    
    var body: some View {
        VStack {
            Text("Child View")
                .font(.headline)
            
            Toggle("Activate Feature", isOn: $isParentToggleOn)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
        }
    }
}

struct ContentView: View {
    @State private var isFeatureActive = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Parent View")
                .font(.largeTitle.bold())
            
            Text("Feature is \(isFeatureActive ? "ON" : "OFF")")
                .font(.title2)
                .foregroundColor(isFeatureActive ? .green : .red)
            
            Divider()
            
            ChildView(isParentToggleOn: $isFeatureActive)
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
