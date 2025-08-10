//
//  ContentView.swift
//  Combine2
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var message: String = "Tap the button to say hello!"
    private var cancellable: AnyCancellable?

    func sayHello() {
        let futurePublisher = Future<String, Never> { promise in
            print("Future is starting its work...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(.success("Hello, Future Combine!"))
            }
        }

        cancellable = futurePublisher
            .sink { value in
                print("Received value: \(value)")
                self.message = value
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

            Button("Say Hello with Future") {
                viewModel.sayHello()
            }
            .font(.headline)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
