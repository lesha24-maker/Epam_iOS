//
//  ContentView.swift
//  Combine5
//
//  Created by Alexey Lim on 10/8/25.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var debouncedText: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .assign(to: \.debouncedText, on: self)
            .store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Debounce Operator Demo")
                .font(.largeTitle)
                .multilineTextAlignment(.center)

            Text("Type below. The final query will only update after you pause.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            TextField("Type to search...", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title2)

            VStack(alignment: .leading, spacing: 10) {
                Text("Live Input:")
                    .font(.headline)
                Text(viewModel.searchText.isEmpty ? "..." : viewModel.searchText)
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                Text("Debounced Output (Final Query):")
                    .font(.headline)
                Text(viewModel.debouncedText.isEmpty ? "..." : viewModel.debouncedText)
                    .fontWeight(.bold)
                    .font(.title3)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)

            Spacer()
        }
        .padding()
    }
}
