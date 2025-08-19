//
//  SettingsView.swift
//  LayoutModifiers8
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
            
            Button("Go to Profile") {
                path.append(.profile)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Settings")
    }
}
