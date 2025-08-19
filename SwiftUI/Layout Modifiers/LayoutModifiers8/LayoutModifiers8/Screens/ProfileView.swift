//
//  ProfileView.swift
//  LayoutModifiers8
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: [Route]

    var body: some View {
        VStack(spacing: 20) {
            Text("User Profile")
                .font(.largeTitle)
            
            Button("Go to Home") {
                path.removeAll()
            }
            .buttonStyle(.bordered)
        }
        .navigationTitle("Profile")
    }
}
