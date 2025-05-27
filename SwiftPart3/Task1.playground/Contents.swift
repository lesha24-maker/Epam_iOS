import Foundation

protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    func checkIn()
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let returnDate = returnDate else { return false }
        return Date() > returnDate
    }
}

class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
    
    override init(id: String, title: String, author: String) {
        super.init(id: id, title: title, author: author)
    }
    
    func borrowBook(for days: Int = 14) {
        let currentDate = Date()
        borrowDate = currentDate
        returnDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate)
        isBorrowed = true
    }
    
    func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
    }
}

enum LibraryError: Error, LocalizedError {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
    
    var errorDescription: String? {
        switch self {
        case .itemNotFound:
            return "The requested item was not found in the library."
        case .itemNotBorrowable:
            return "This item cannot be borrowed."
        case .alreadyBorrowed:
            return "This item is already borrowed."
        }
    }
}

class Library {
    private var items: [String: Item] = [:]
    
    func addBook(_ book: Book) {
        items[book.id] = book
    }
    
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard let borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        if let book = item as? Book {
            book.borrowBook()
        }
        
        return item
    }
    
    func returnItem(by id: String) throws {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard let borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if let book = item as? Book {
            book.checkIn()
        }
    }
    
    func getAllItems() -> [Item] {
        return Array(items.values)
    }
    
    func getItem(by id: String) -> Item? {
        return items[id]
    }
    
    func getBorrowedItems() -> [Item] {
        return items.values.compactMap { item in
            if let borrowable = item as? Borrowable, borrowable.isBorrowed {
                return item
            }
            return nil
        }
    }
    
    func getOverdueItems() -> [Item] {
        return items.values.compactMap { item in
            if let borrowable = item as? Borrowable, borrowable.isOverdue() {
                return item
            }
            return nil
        }
    }
}

func demonstrateLibrarySystem() {
    let library = Library()
    
    let book1 = Book(id: "001", title: "The Swift Programming Language", author: "Apple Inc.")
    let book2 = Book(id: "002", title: "iOS Development with Swift", author: "John Doe")
    let book3 = Book(id: "003", title: "Design Patterns", author: "Gang of Four")
    
    library.addBook(book1)
    library.addBook(book2)
    library.addBook(book3)
    
    print("=== Library Management System Demo ===\n")
    
    do {
        let borrowedItem = try library.borrowItem(by: "001")
        print("✅ Successfully borrowed: \(borrowedItem.title)")
        
        if let book = borrowedItem as? Book {
            print("   Borrowed on: \(book.borrowDate?.description ?? "Unknown")")
            print("   Return by: \(book.returnDate?.description ?? "Unknown")")
        }
    } catch {
        print("❌ Error borrowing item: \(error.localizedDescription)")
    }
    
    print()
    
    do {
        let _ = try library.borrowItem(by: "001")
        print("This shouldn't print")
    } catch LibraryError.alreadyBorrowed {
        print("❌ Cannot borrow: Item is already borrowed")
    } catch {
        print("❌ Unexpected error: \(error.localizedDescription)")
    }
    
    print()
    
    do {
        let _ = try library.borrowItem(by: "999")
        print("This shouldn't print")
    } catch LibraryError.itemNotFound {
        print("❌ Cannot borrow: Item not found")
    } catch {
        print("❌ Unexpected error: \(error.localizedDescription)")
    }
    
    print()
    
    do {
        try library.returnItem(by: "001")
        print("✅ Successfully returned item with ID: 001")
    } catch {
        print("❌ Error returning item: \(error.localizedDescription)")
    }
    
    print()
    
    print("=== Library Status ===")
    print("Total items: \(library.getAllItems().count)")
    print("Borrowed items: \(library.getBorrowedItems().count)")
    print("Overdue items: \(library.getOverdueItems().count)")
}

demonstrateLibrarySystem()
