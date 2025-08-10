//
//  ContentView.swift
//  Combine4
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var sentMessages: [String] = []
    @Published var receivedEvenNumbers: [String] = []

    private var counter = 0
    
    private let numberSubject = PassthroughSubject<Int, Never>()
    
    private var cancellable: AnyCancellable?

    init() {
        cancellable = numberSubject
            .receive(on: DispatchQueue.main)
            .filter { number in
                return number % 2 == 0
            }
            .sink { evenNumber in
                self.receivedEvenNumbers.append("Received: \(evenNumber)")
            }
    }

    func sendNextNumber() {
        counter += 1
        let message = "Sending number: \(counter)"
        print(message)
        sentMessages.append(message)
        numberSubject.send(counter)
    }
}

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Using Combine's Filter Operator")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button("Send Next Number") {
                viewModel.sendNextNumber()
            }
            .font(.headline)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            HStack {
                VStack {
                    Text("All Sent Numbers").font(.headline)
                    List(viewModel.sentMessages, id: \.self) { message in
                        Text(message)
                    }
                    .listStyle(PlainListStyle())
                }
                
                VStack {
                    Text("Filtered Even Numbers").font(.headline)
                    List(viewModel.receivedEvenNumbers, id: \.self) { message in
                        Text(message).bold()
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .padding()
    }
}
