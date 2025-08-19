//
//  DetailView.swift
//  LayoutModifiers7
//
//  Created by Alexey Lim on 19/8/25.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI Navigation!")
                .font(.title)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView()
}
