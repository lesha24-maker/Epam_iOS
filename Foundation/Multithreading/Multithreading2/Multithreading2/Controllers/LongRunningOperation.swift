//
//  LongRunningOperation.swift
//  Multithreading2
//
//  Created by Alexey Lim on 30/7/25.
//

import Foundation

class LongRunningOperation: Operation {
    let operationName: String
    var onStatusUpdate: ((String) -> Void)?
    
    init(name: String) {
        self.operationName = name
        super.init()
    }
    
    override func main() {
        DispatchQueue.main.async {
            self.onStatusUpdate?("Operation \"\(self.operationName)\" started")
        }
        
        for i in 0..<1000000 {
            if isCancelled {
                DispatchQueue.main.async {
                    self.onStatusUpdate?("Operation \"\(self.operationName)\" was cancelled")
                }
                return
            }
            
            if i % 200000 == 0 && i > 0 {
                DispatchQueue.main.async {
                    self.onStatusUpdate?("Operation \"\(self.operationName)\" progress: \(i/10000)%")
                }
            }
        }
        
        DispatchQueue.main.async {
            self.onStatusUpdate?("Operation \"\(self.operationName)\" finished")
        }
    }
}

