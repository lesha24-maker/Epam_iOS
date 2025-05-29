import Foundation

protocol Borrowable: AnyObject {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    func checkIn()
    func setBorrowed(for days: Int)
}

extension Borrowable {
    func isOverdue() -> Bool {
        guard let definiteReturnDate = returnDate, isBorrowed else {
            return false
        }
        return Date() > definiteReturnDate
    }

    func checkIn() {
        self.borrowDate = nil
        self.returnDate = nil
        self.isBorrowed = false
    }
    
    func setBorrowed(for days: Int = 14) {
        let currentDate = Date()
        self.borrowDate = currentDate
        self.returnDate = Calendar.current.date(byAdding: .day, value: days, to: currentDate)
        self.isBorrowed = true
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

    func getItemDetails() -> String {
        return "ID: \(id), Title: \"\(title)\", Author: \(author)"
    }
}

class Book: Item, Borrowable {
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false

    override init(id: String, title: String, author: String) {
        super.init(id: id, title: title, author: author)
    }
}

class Magazine: Item, Borrowable {
    var issueNumber: Int
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
    
    init(id: String, title: String, author: String, issueNumber: Int) {
        self.issueNumber = issueNumber
        super.init(id: id, title: title, author: author)
    }
}

enum LibraryError: Error, LocalizedError {
    case itemNotFound(itemID: String)
    case itemNotBorrowable(itemID: String)
    case alreadyBorrowed(itemID: String, title: String)
    case notCurrentlyBorrowed(itemID: String, title: String)

    var errorDescription: String? {
        switch self {
        case .itemNotFound(let itemID):
            return "The requested item with ID '\(itemID)' was not found in the library."
        case .itemNotBorrowable(let itemID):
            return "Item with ID '\(itemID)' cannot be borrowed as it does not conform to Borrowable."
        case .alreadyBorrowed(let itemID, let title):
            return "Item '\(title)' (ID: \(itemID)) is already borrowed."
        case .notCurrentlyBorrowed(let itemID, let title):
            return "Item '\(title)' (ID: \(itemID)) is not currently borrowed and cannot be checked in."
        }
    }
}

class Library {
    private var items: [String: Item] = [:]
    
    func addItem(_ item: Item) {
        items[item.id] = item
        print("Item added: \"\(item.title)\" (ID: \(item.id))")
    }

    func addBook(_ book: Book) {
        addItem(book)
    }
    
    func borrowItem(by id: String, for days: Int = 14) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound(itemID: id)
        }
        
        guard var borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable(itemID: id)
        }
        
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed(itemID: id, title: item.title)
        }
        
        borrowableItem.setBorrowed(for: days)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let returnDateString = borrowableItem.returnDate.map { dateFormatter.string(from: $0) } ?? "N/A"

        print("✅ Successfully borrowed: \"\(item.title)\" (ID: \(id)). Return by: \(returnDateString)")
        return item
    }
    
    func returnItem(by id: String) throws {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound(itemID: id)
        }
        
        guard let borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable(itemID: id)
        }

        guard borrowableItem.isBorrowed else {
            throw LibraryError.notCurrentlyBorrowed(itemID: id, title: item.title)
        }
        
        borrowableItem.checkIn()
        print("✅ Successfully returned: \"\(item.title)\" (ID: \(id))")
    }
    
    func getItem(by id: String) -> Item? {
        return items[id]
    }

    var totalItemCount: Int {
        return items.count
    }

    func listAllItems() {
        print("\n--- Library Catalog ---")
        if items.isEmpty {
            print("The library is empty.")
            return
        }
        for (_, item) in items.sorted(by: { $0.key < $1.key }) {
            var status = ""
            if let borrowable = item as? Borrowable {
                status = borrowable.isBorrowed ? "Borrowed (Return by: \(borrowable.returnDate.map { DateFormatter.localizedString(from: $0, dateStyle: .short, timeStyle: .none) } ?? "N/A"))" : "Available"
                if borrowable.isBorrowed && borrowable.isOverdue() {
                    status += " - OVERDUE!"
                }
            } else {
                 status = "Non-Borrowable Item"
            }
            print("\(item.getItemDetails()) - Status: \(status)")
        }
        print("-----------------------\n")
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
            if let borrowable = item as? Borrowable, borrowable.isBorrowed, borrowable.isOverdue() {
                return item
            }
            return nil
        }
    }
}

func demonstrateLibrarySystem() {
    let library = Library()
    
    let book1 = Book(id: "B001", title: "The Swift Guide", author: "Central Processors")
    let book2 = Book(id: "B002", title: "Advanced iOS", author: "Ada Byte")
    let book3 = Book(id: "B003", title: "Pattern Recognition", author: "Ctrl Alt Design")
    let magazine1 = Magazine(id: "M001", title: "Tech Monthly", author: "Various", issueNumber: 42)
    
    library.addBook(book1)
    library.addBook(book2)
    library.addBook(book3)
    library.addItem(magazine1)
    
    print("=== Library Management System Demo ===\n")
    library.listAllItems()
    
    do {
        _ = try library.borrowItem(by: "B001")
        _ = try library.borrowItem(by: "M001", for: 7)
    } catch {
        print("❌ Error during initial borrowing: \(error.localizedDescription)")
    }
    
    library.listAllItems()
    
    print("\n--- Attempting to borrow B001 again ---")
    do {
        _ = try library.borrowItem(by: "B001")
        print("This shouldn't print (B001 already borrowed)")
    } catch LibraryError.alreadyBorrowed(let id, let title) {
        print("🔶 Cannot borrow again: Item '\(title)' (ID: \(id)) is already borrowed.")
    } catch {
        print("❌ Unexpected error borrowing B001 again: \(error.localizedDescription)")
    }
    
    print("\n--- Attempting to borrow B999 ---")
    do {
        _ = try library.borrowItem(by: "B999")
        print("This shouldn't print (B999 not found)")
    } catch LibraryError.itemNotFound(let id) {
        print("🔶 Cannot borrow: Item with ID '\(id)' not found.")
    } catch {
        print("❌ Unexpected error borrowing B999: \(error.localizedDescription)")
    }
    
    print("\n--- Returning items ---")
    do {
        try library.returnItem(by: "B001")
    } catch {
        print("❌ Error returning B001: \(error.localizedDescription)")
    }
    
    library.listAllItems()
    
    print("\n--- Overdue Check ---")
    if let borrowedMagazine = library.getItem(by: "M001") as? Borrowable {
        borrowedMagazine.returnDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        print("Is magazine M001 overdue? \(borrowedMagazine.isOverdue()) (Should be true)")
    }
    
    print("Overdue items in library: \(library.getOverdueItems().map { $0.title }.joined(separator: ", ") )")
    library.listAllItems()

    print("\n--- Attempting to return B001 again (not borrowed) ---")
    do {
        try library.returnItem(by: "B001")
        print("This shouldn't print (B001 not borrowed)")
    } catch LibraryError.notCurrentlyBorrowed(let id, let title) {
        print("🔶 Cannot return: Item '\(title)' (ID: \(id)) is not currently borrowed.")
    } catch {
        print("❌ Unexpected error returning B001 again: \(error.localizedDescription)")
    }
    
    print("\n=== Final Library Status ===")
    print("Total items: \(library.totalItemCount)")
    print("Borrowed items: \(library.getBorrowedItems().count)")
    print("Overdue items: \(library.getOverdueItems().count)")
}

demonstrateLibrarySystem()
