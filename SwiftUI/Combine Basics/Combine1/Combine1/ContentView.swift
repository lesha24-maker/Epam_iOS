//
//  ContentView.swift
//  Combine1
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var message: String = "Tap the button to say hello!"
    private var cancellable: AnyCancellable?

    func sayHello() {
        let justPublisher = Just("Hello, Combine!")

        cancellable = justPublisher
            .sink { [weak self] value in
                self?.message = value
            }
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()

            Button("Say Hello") {
                viewModel.sayHello()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

