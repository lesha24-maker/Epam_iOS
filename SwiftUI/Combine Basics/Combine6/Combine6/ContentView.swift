//
//  ContentView.swift
//  Combine6
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var sentNumbersLog: [String] = []
    @Published var receivedSquaresLog: [String] = []
    
    private let numberSubject = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var counter = 0
    
    init() {
        numberSubject
            .flatMap { number -> Future<String, Never> in
                return Future { promise in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        let result = "\(number) * \(number) = \(number * number)"
                        promise(.success(result))
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] squaredValue in
                self?.receivedSquaresLog.append(squaredValue)
            }
            .store(in: &cancellables)
    }
    
    func sendNextNumber() {
        counter += 1
        sentNumbersLog.append("-> Sent: \(counter)")
        numberSubject.send(counter)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("flatMap Operator Demo")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Each number triggers a new delayed publisher for its square.")
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Button("Send Next Number") {
                viewModel.sendNextNumber()
            }
            .font(.headline)
            .padding()
            .background(Color.purple)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            HStack(alignment: .top, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Sent Stream").font(.headline)
                    ForEach(viewModel.sentNumbersLog, id: \.self) { log in
                        Text(log)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.systemGray5))
                            .cornerRadius(5)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Received from flatMap").font(.headline)
                    ForEach(viewModel.receivedSquaresLog, id: \.self) { log in
                        Text(log)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(5)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

