//
//  SettingsView.swift
//  LayoutModifiers10
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.orange.opacity(0.2).ignoresSafeArea()
            
            Text("Settings Screen")
                .font(.largeTitle)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
