//
//  HostedSwiftUIView.swift
//  EnvironmentObjects3
//
//  Created by Alexey Lim on 22/8/25.
//

import SwiftUI

struct HostedSwiftUIView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "swift")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            Text("This view is built with SwiftUI!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Text("It's being hosted inside a UIKit ViewController.")
                .font(.headline)
                .foregroundColor(.secondary)
        
            Button("Dismiss") {
                dismiss()
            }
            .font(.title2)
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    HostedSwiftUIView()
}
