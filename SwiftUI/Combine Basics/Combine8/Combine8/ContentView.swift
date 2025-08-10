//
//  ContentView.swift
//  Combine8
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newLoadingState in
                print("Loading state changed to: \(newLoadingState)")
                if newLoadingState {
                    self?.loadData()
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isLoading = false
        }
    }
    
    func startLoading() {
        self.isLoading = true
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Published Property Demo")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                    .scaleEffect(2)
                Text("Loading Data...")
                    .font(.title2)
                    .foregroundColor(.orange)
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                Text("Finished Loading")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
            Button(action: {
                viewModel.startLoading()
            }) {
                Text("Fetch Data")
                    .font(.title)
                    .padding()
                    .background(viewModel.isLoading ? Color.gray : Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.isLoading)
        }
        .padding()
    }
}
