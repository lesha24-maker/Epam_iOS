import Foundation

func fetchData(from source: String, completion: @escaping () -> Void) {
    print("\(source) - Fetching data...")
    sleep(UInt32.random(in: 1...3))
    print("\(source) - Data fetched ✅")
    completion()
}

func runGCDTask() {
    let queue = DispatchQueue.global(qos: .userInitiated)
    let sources = ["API 1", "API 2", "API 3"]
    
    let dispatchGroup = DispatchGroup()

    for source in sources {
        dispatchGroup.enter()
        queue.async {
            fetchData(from: source) {
                print("\(source) - Processing complete")
                dispatchGroup.leave()
            }
        }
    }
    
    print("🚀 All tasks dispatched. Waiting for completion...")

    dispatchGroup.notify(queue: .main) {
        print("✅ All tasks completed. Updating UI now!")
    }
}

runGCDTask()

RunLoop.current.run(until: Date(timeIntervalSinceNow: 5))
