//
//  PrimaryButtonStyle.swift
//  LayoutModifiers6
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct PrimaryButtonStyle: ViewModifier {
    @Environment(\.isEnabled) private var isEnabled
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .background(isEnabled ? Color.blue : Color.gray.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        self.modifier(PrimaryButtonStyle())
    }
}
