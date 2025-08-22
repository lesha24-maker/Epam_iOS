//
//  ContentView.swift
//  EnvironmentObjects4
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Text("This is a native SwiftUI Text view, displayed above the UIKit view.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            
                MyUIKitViewRepresentable()
                    .frame(height: 200)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                
                Text("The blue-green area above is a UIViewController being displayed inside a SwiftUI layout.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .navigationTitle("SwiftUI & UIKit")
        }
    }
}

#Preview {
    ContentView()
}
