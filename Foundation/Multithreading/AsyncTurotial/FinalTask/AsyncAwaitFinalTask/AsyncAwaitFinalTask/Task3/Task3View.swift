//
//  Task3View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 05/07/2024.
//

import SwiftUI

struct Task3View: View {
    @State var currentStrength: Task3API.SignalStrenght = .unknown
    @State var running: Bool = false
    
    let api = Task3API()
    
    var body: some View {
        VStack {
            HStack {
                Text("Current signal strength: \(currentStrength.rawValue)")
            }
            .padding()
            
            Button {
                running.toggle()
                if !running {
                    api.cancel()
                } else {
                    Task {
                        let stream = api.signalStrength()
                        for await strength in stream {
                            currentStrength = strength
                        }
                        currentStrength = .unknown
                        print("stream finished")
                    }
                }
            } label: {
                Text(running ? "Cancel" : "Start monitoring")
            }
        }
    }
}

class Task3API {
    enum SignalStrenght: String {
        case weak, strong, excellent, unknown
    }
    
    private var monitoringTask: Task<Void, Never>?
    
    func signalStrength() -> AsyncStream<SignalStrenght> {
        return AsyncStream { continuation in
            self.monitoringTask = Task {
                while !Task.isCancelled {
                    do {
                        try await Task.sleep(for: .seconds(1))
                        let randomStrength = [SignalStrenght.weak, .strong, .excellent].randomElement() ?? .unknown
                        continuation.yield(randomStrength)
                    } catch {
                        break
                    }
                }
                continuation.finish()
            }
        }
    }
    
    func cancel() {
        monitoringTask?.cancel()
    }
}

#Preview {
    Task3View()
}
