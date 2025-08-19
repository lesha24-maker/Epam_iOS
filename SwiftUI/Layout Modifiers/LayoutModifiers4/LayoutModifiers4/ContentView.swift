//
//  ContentView.swift
//  LayoutModifiers4
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .offset(x: -40, y: -40)
                .shadow(radius: 5)

            Rectangle()
                .fill(Color.green)
                .frame(width: 150, height: 100)
                .cornerRadius(10)
                .offset(x: 50, y: 150)
                .shadow(radius: 5)
            
            Text("Original Center")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(5)
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(5)
        }
    
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
