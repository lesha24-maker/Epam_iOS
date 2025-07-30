//
//  SwiftUIView.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 4/9/24.
//

import SwiftUI

struct Task1View: View, @unchecked Sendable {
    let task1API = Task1API()
    @State var fact = "To get random number fact presss button below"
    
    var body: some View {
        VStack {
            Text(fact)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                Task {
                    do {
                        fact = try await task1API.getTrivia(for: .none)
                    } catch {
                        fact = "Loading error: \(error.localizedDescription)"
                    }
                }
            }, label: { Text("Click me") })
        }
    }
}

#Preview {
    Task1View()
}

class Task1API: @unchecked Sendable {
    let baseURL = "http://numbersapi.com"
    let triviaPath = "random/trivia"
    private var session = URLSession.shared
    
    enum APIError: Error {
        case invalidURL
    }
    
    func getTrivia(for number: Int?) async throws -> String {
        guard let url = URL(string: baseURL)?.appendingPathComponent(triviaPath) else {
            throw APIError.invalidURL
        }
        
        let (data, _) = try await session.data(from: url)
        
        let randomFact = String(data: data, encoding: .utf8) ?? "Could not decode fact"
        
        return randomFact
    }
}
