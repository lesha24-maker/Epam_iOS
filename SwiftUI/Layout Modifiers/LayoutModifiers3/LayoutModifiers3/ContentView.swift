//
//  ContentView.swift
//  LayoutModifiers3
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            
            VStack(alignment: .leading) {
                Text("Alignment: .center (Default)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .center, spacing: 20) {
                    Text("Item 1")
                        .font(.largeTitle)
                    
                    Text("Item 2")
                        .font(.body)
                    
                    Text("Item 3")
                        .font(.caption)
                }
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text("Alignment: .top")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(alignment: .top, spacing: 20) {
                    Text("Item 1")
                        .font(.largeTitle)
                    
                    Text("Item 2")
                        .font(.body)
                    
                    Text("Item 3")
                        .font(.caption)
                }
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text("Alignment: .bottom")
                    .font(.caption)
                    .foregroundColor(.secondary)

                HStack(alignment: .bottom, spacing: 20) {
                    Text("Item 1")
                        .font(.largeTitle)
                    
                    Text("Item 2")
                        .font(.body)
                    
                    Text("Item 3")
                        .font(.caption)
                }
                .padding()
                .background(Color.orange.opacity(0.2))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
