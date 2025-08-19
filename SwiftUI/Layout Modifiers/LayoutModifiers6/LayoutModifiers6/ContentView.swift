//
//  ContentView.swift
//  LayoutModifiers6
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var canSubmit = false

    var body: some View {
        VStack(spacing: 30) {
            Toggle("Enable Submit Button", isOn: $canSubmit.animation())

            Button("Submit") {
                print("Submit button tapped!")
            }
            .primaryButtonStyle()
            .disabled(!canSubmit) 
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
