//
//  Task4View.swift
//  AsyncAwaitFinalTask
//
//  Created by Nikolay Dechko on 08/07/2024.
//

import SwiftUI

struct Task4View: View {
    let api = Task4ViewAPI()
    @State var finished: Bool = false
    @State var ballance: Int = 1000
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Starting balance: 1000")
            if finished {
                Text("Final balance: \(ballance)")
                    .font(.title)
                    .foregroundColor(ballance == 0 ? .green : .red)
                
                Text(ballance == 0 ? "Success" : "Failure")
                    .font(.headline)
            }
            
            Button {
                if finished {
                    Task {
                        await api.reset()
                    }
                    self.ballance = 1000
                    self.finished = false
                } else {
                    Task {
                        ballance = await api.startUpdate()
                        self.finished = true
                    }
                }
            } label: {
                Text(finished ? "Reset" : "Start")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    Task4View()
}

actor Task4ViewAPI {
    private(set) var ballance: Int = 1000
    
    func decrement() {
        self.ballance -= 1
    }
    
    func reset() {
        self.ballance = 1000
    }
    
    func startUpdate() async -> Int {
        await withTaskGroup(of: Void.self) { group in
            for _ in 0..<1000 {
                group.addTask {
                    await self.decrement()
                }
            }
        }
        return self.ballance
    }
}
