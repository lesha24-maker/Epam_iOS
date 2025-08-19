//
//  ContentView.swift
//  LayoutModifiers1
//
//  Created by Alexey Lim on 18/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            Text("SwiftUI Layout Modifiers")
                .padding(16)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8) 

            Text("Padding Top Only")
                .padding(.top, 16)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)

            Text("Horizontal Padding")
                .padding(.horizontal, 16)
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            Text("Mixed Padding")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
