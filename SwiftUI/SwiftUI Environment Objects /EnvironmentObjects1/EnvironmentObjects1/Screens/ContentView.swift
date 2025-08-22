//
//  ContentView.swift
//  EnvironmentObjects1
//
//  Created by Alexey Lim on 22/8/25.
//
import SwiftUI

struct CounterDisplayView: View {
    @EnvironmentObject var counter: Counter

    var body: some View {
        Text("Current Value: \(counter.counterValue)")
            .font(.largeTitle.bold())
            .padding()
    }
}

struct IncrementCounterView: View {
    @EnvironmentObject var counter: Counter

    var body: some View {
        Button("Increment +1") {
            counter.counterValue += 1
        }
        .buttonStyle(.borderedProminent)
    }
}

struct DecrementCounterView: View {
    @EnvironmentObject var counter: Counter

    var body: some View {
        Button("Decrement -1") {
            counter.counterValue -= 1
        }
        .buttonStyle(.bordered)
        .tint(.red)
    }
}

struct ContentView: View {
    @StateObject private var counter = Counter()

    var body: some View {
        VStack(spacing: 30) {
            Text("Shared Counter Demo")
                .font(.title.weight(.heavy))
            
            CounterDisplayView()
            
            HStack(spacing: 20) {
                IncrementCounterView()
                DecrementCounterView()
            }
        }
        .environmentObject(counter)
        .padding()
    }
}

#Preview {
    ContentView()
}
