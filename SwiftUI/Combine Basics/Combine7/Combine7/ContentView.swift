//
//  ContentView.swift
//  Combine7
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var tapCount: Int = 0

    let buttonTapSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        buttonTapSubject
            .scan(0) { count, _ in count + 1 }
            .assign(to: \.tapCount, on: self)
            .store(in: &cancellables)
        
        buttonTapSubject
            .scan(0) { count, _ in count + 1 }
            .sink { count in
                print("Button has been pressed \(count) time(s).")
            }
            .store(in: &cancellables)
    }

    func buttonTapped() {
        buttonTapSubject.send()
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Text("Button Press Counter")
                .font(.largeTitle)

            Text("\(viewModel.tapCount)")
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(.blue)

            Button("Press Me") {
                viewModel.buttonTapped()
            }
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

