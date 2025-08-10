//
//  ContentView.swift
//  Combine3
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    let namePublisher = PassthroughSubject<String, Never>()
    let surnamePublisher = PassthroughSubject<String, Never>()

    private var cancellable: AnyCancellable?

    init() {
        cancellable = Publishers.CombineLatest(
            namePublisher.map { $0.uppercased() },
            surnamePublisher
        )
        .map { name, surname in
            "\(name) \(surname)"
        }
        .sink { combinedValue in
            print("Combined and Formatted: \(combinedValue)")
        }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var name: String = ""
    @State private var surname: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter your name and surname below")
                .font(.headline)

            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: name) { newValue in
                    viewModel.namePublisher.send(newValue)
                }

            TextField("Surname", text: $surname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onChange(of: surname) { newValue in
                    viewModel.surnamePublisher.send(newValue)
                }

            Spacer()
        }
        .padding()
        .navigationTitle("Combine Publishers")
    }
}
