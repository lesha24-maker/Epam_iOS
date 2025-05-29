import Foundation

class Stack<T> {
    private var items: [T] = []

    func push(_ element: T) {
        items.append(element)
    }

    func pop() -> T? {
        return items.popLast()
    }

    func size() -> Int {
        return items.count
    }

    func printStackContents() -> String {
        if items.isEmpty {
            return "Stack is empty."
        }
        var description = "---- Top ----\n"
        for item in items.reversed() {
            description += "\(item)\n"
        }
        description += "---- Bottom ----"
        return description
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    func peek() -> T? {
        return items.last
    }
}

print("--- Testing Stack with Integers ---")
let intStack = Stack<Int>()
print("Initial size: \(intStack.size())")
print(intStack.printStackContents())

intStack.push(10)
intStack.push(20)
intStack.push(30)

print("\nAfter pushing 10, 20, 30:")
print("Size: \(intStack.size())")
print(intStack.printStackContents())

if let poppedItem = intStack.pop() {
    print("\nPopped: \(poppedItem)")
}
print("Size after pop: \(intStack.size())")
print(intStack.printStackContents())

print("\nPopping remaining elements:")
print("Popped: \(intStack.pop() ?? -1)")
print("Popped: \(intStack.pop() ?? -1)")
print("Popped: \(intStack.pop() ?? -1)")

print("Size after all pops: \(intStack.size())")
print(intStack.printStackContents())


print("\n--- Testing Stack with Strings ---")
let stringStack = Stack<String>()
stringStack.push("Hello")
stringStack.push("World")
stringStack.push("Swift")

print("Size: \(stringStack.size())")
print(stringStack.printStackContents())

if let topString = stringStack.peek() {
    print("\nPeeking top: \(topString)")
}
print("Size after peek: \(stringStack.size())")

if let poppedString = stringStack.pop() {
    print("Popped: \(poppedString)")
}
print("Size after pop: \(stringStack.size())")
print(stringStack.printStackContents())

struct Book: CustomStringConvertible {
    let title: String
    let author: String

    var description: String {
        return "\"\(title)\" by \(author)"
    }
}

print("\n--- Testing Stack with Custom Struct (Book) ---")
let bookStack = Stack<Book>()
bookStack.push(Book(title: "The Swift Programming Language", author: "Apple Inc."))
bookStack.push(Book(title: "Design Patterns", author: "GoF"))

print("Size: \(bookStack.size())")
print(bookStack.printStackContents())

if let poppedBook = bookStack.pop() {
    print("\nPopped: \(poppedBook)")
}
print(bookStack.printStackContents())
