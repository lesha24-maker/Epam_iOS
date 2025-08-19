//
//  HomeView.swift
//  LayoutModifiers8
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Home")
                .font(.largeTitle)
            
            Button("Go to Settings") {
                path.append(.settings)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Home")
    }
}
