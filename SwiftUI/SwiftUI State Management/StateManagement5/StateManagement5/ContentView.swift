//
//  ContentView.swift
//  StateManagement5
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var formModel = FormModel()

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Account Details")) {
                    TextField("Enter username", text: $formModel.username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Button("Submit") {
                        submitForm()
                    }
                    .disabled(formModel.isSubmitButtonDisabled)
                }
            }
            .navigationTitle("Login")
        }
    }
    
    func submitForm() {
        print("Form submitted with username: \(formModel.username)")
    }
}

#Preview {
    ContentView()
}
