import Foundation

let semaphore = DispatchSemaphore(value: 2)

func performTask(id: Int) {
    semaphore.wait()
    defer { semaphore.signal() }
    
    print("Task \(id) started")
    sleep(1)
    print("Task \(id) finished")
}

func runConcurrentTasks() {
    let threads = (1...5).map { id in
        Thread {
            performTask(id: id)
        }
    }
    
    threads.forEach { $0.start() }
    
    while threads.contains(where: { $0.isExecuting }) {
        usleep(100)
    }
}

runConcurrentTasks()
