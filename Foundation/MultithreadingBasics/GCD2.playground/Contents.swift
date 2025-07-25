import Foundation

func executeTask(_ taskNumber: Int, delay: UInt32) {
    print("➡️ Task \(taskNumber) started on thread \(Thread.current)")
    sleep(delay)
    print("✅ Task \(taskNumber) finished")
}

func executeTasks() {
    let concurrentQueue = DispatchQueue(label: "com.example.concurrentQueue", attributes: .concurrent)
    let finalQueue = DispatchQueue(label: "com.example.finalQueue")

    let group = DispatchGroup()

    group.enter()
    concurrentQueue.async {
        executeTask(1, delay: 2)
        group.leave()
    }

    
    group.enter()
    concurrentQueue.async {
        executeTask(2, delay: 3)
        group.leave()
    }
    
    print("🚀 Tasks 1 and 2 dispatched. Waiting for them to complete...")

    group.notify(queue: finalQueue) {
        print("🔔 Group finished. Starting the final task.")
        executeTask(3, delay: 1)
    }
}

executeTasks()

Thread.sleep(forTimeInterval: 7)
