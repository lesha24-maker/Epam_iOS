//
//  ContentView.swift
//  LayoutModifiers5
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 50) {
            
            VStack {
                Text("Background & Overlay")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("SwiftUI is amazing!")
                    .font(.headline)
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    )
                    .overlay(
                        Circle()
                            .fill(Color.blue.opacity(0.3))
                    )
            }
            
            VStack {
                Text("Using clipShape")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("SwiftUI is amazing!")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 200, height: 200)
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
