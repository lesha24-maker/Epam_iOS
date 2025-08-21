//
//  ContentView.swift
//  StateManagement4
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI
import Observation

@Observable
class UserProfile {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
}

struct ContentView: View {
    
    @State private var user = UserProfile(name: "Aleksei Lim", email: "aleksei_lim@eopam.com")
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Edit Profile")) {
                    TextField("Name", text: $user.name)
                    
                    TextField("Email", text: $user.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Live Data Preview")) {
                    Text("Current Name: \(user.name)")
                    Text("Current Email: \(user.email)")
                }
            }
            .navigationTitle("Observable Profile")
        }
    }
}

#Preview {
    ContentView()
}
