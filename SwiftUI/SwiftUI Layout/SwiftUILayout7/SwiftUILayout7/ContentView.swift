//
//  ContentView.swift
//  SwiftUILayout7
//
//  Created by Alexey Lim on 16/8/25.
//

import SwiftUI

struct ContentView: View {
    let standardUser = User(name: "Nikita Dugai", age: 21, location: "Prague", isPremium: false)
    let premiumUser = User(name: "Aleksei Lim", age: 21, location: "Bishkek", isPremium: true)
    
    var body: some View {
        VStack(spacing: 40) {
            ProfileDetailView(user: standardUser)
            ProfileDetailView(user: premiumUser)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
