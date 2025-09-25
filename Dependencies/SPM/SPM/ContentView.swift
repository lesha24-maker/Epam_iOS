//
//  ContentView.swift
//  SPM
//
//  Created by Alexey Lim on 9/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Hello from SwiftUI!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
            
            ProfileInfoViewRepresentable()
                .frame(height: 250)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
