//
//  ContentView.swift
//  StateManagement7
//
//  Created by Alexey Lim on 21/8/25.
//

import SwiftUI

struct CounterDisplayViewA: View {
    @Environment(SharedCounter.self) private var counter
    
    var body: some View {
        VStack {
            Text("View A")
                .font(.headline)
            Text("Count: \(counter.count)")
                .font(.largeTitle.bold())
                .contentTransition(.numericText())
            
            Button("Increment from View A") {
                withAnimation {
                    counter.count += 1
                }
            }
        }
    }
}

struct CounterDisplayViewB: View {
    @Environment(SharedCounter.self) private var counter
    
    var body: some View {
        VStack {
            Text("View B")
                .font(.headline)
            Text("Count: \(counter.count)")
                .font(.largeTitle.bold())
                .contentTransition(.numericText())
            
            Button("Increment from View B") {
                withAnimation {
                    counter.count += 1
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var sharedCounter = SharedCounter()
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Shared Counter Demo")
                .font(.title.weight(.heavy))
            
            CounterDisplayViewA()
            
            Divider()
            
            CounterDisplayViewB()
        }
        .environment(sharedCounter)
        .padding()
    }
}

#Preview {
    ContentView()
}
