//
//  CustomBlockOperation.swift
//  Multithreading3
//
//  Created by Alexey Lim on 30/7/25.
//

import Foundation

class CustomBlockOperation: Operation {
    let operationName: String
    var onStatusUpdate: ((String) -> Void)?
    private let workBlock: () -> Void
    
    init(name: String, block: @escaping () -> Void) {
        self.operationName = name
        self.workBlock = block
        super.init()
    }
    
    override func main() {
        guard !isCancelled else {
            DispatchQueue.main.async {
                self.onStatusUpdate?("Operation \"\(self.operationName)\" was cancelled before starting")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.onStatusUpdate?("Operation \"\(self.operationName)\" started")
        }
        
        workBlock()
        
        guard !isCancelled else {
            DispatchQueue.main.async {
                self.onStatusUpdate?("Operation \"\(self.operationName)\" was cancelled during execution")
            }
            return
        }
        
        DispatchQueue.main.async {
            self.onStatusUpdate?("Operation \"\(self.operationName)\" finished")
        }
    }
}

