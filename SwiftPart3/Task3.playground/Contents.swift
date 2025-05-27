import Foundation

nonisolated(unsafe) let books = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]]
]

let discountedPrices: [Double] = books.compactMap { book in
    guard let price = book["price"] as? Int else { return nil }
    return Double(price) * 0.9
}

let booksPostedAfter2000: [String] = books.compactMap { book in
    guard let title = book["title"] as? String,
          let year = book["year"] as? Int,
          year > 2000 else { return nil }
    return title
}

let allGenres: Set<String> = Set(books.flatMap { book in
    return (book["genre"] as? [String]) ?? []
})

let totalCost: Int = books.reduce(0) { total, book in
    let price = book["price"] as? Int ?? 0
    return total + price
}

func demonstrateResults() {
    print("=== BOOK COLLECTION PROCESSING ===\n")
    
    print("Original Books:")
    for book in books {
        let title = book["title"] as? String ?? "Unknown"
        let author = book["author"] as? String ?? "Unknown"
        let year = book["year"] as? Int ?? 0
        let price = book["price"] as? Int ?? 0
        print("• \(title) by \(author) (\(year)) - $\(price)")
    }
    
    print("\nDiscounted Prices (10% off):")
    for (index, price) in discountedPrices.enumerated() {
        let title = books[index]["title"] as? String ?? "Unknown"
        print("• \(title): $\(String(format: "%.2f", price))")
    }
    
    print("\nBooks Published After 2000:")
    for title in booksPostedAfter2000 {
        print("• \(title)")
    }
    
    print("\nAll Genres:")
    for genre in allGenres.sorted() {
        print("• \(genre)")
    }
    
    print("\nTotal Cost: $\(totalCost)")
    
    print("\n=== STATISTICS ===")
    print("Total books: \(books.count)")
    print("Books after 2000: \(booksPostedAfter2000.count)")
    print("Unique genres: \(allGenres.count)")
    print("Average price: $\(String(format: "%.2f", Double(totalCost) / Double(books.count)))")
    print("Average discounted price: $\(String(format: "%.2f", discountedPrices.reduce(0, +) / Double(discountedPrices.count)))")
}

func demonstrateHigherOrderFunctions() {
    print("\n=== HIGHER-ORDER FUNCTIONS EXAMPLES ===\n")
    
    print("1. Using map to get all titles:")
    let titles = books.map { $0["title"] as? String ?? "Unknown" }
    print(titles.joined(separator: ", "))
    
    print("\n2. Using filter to get expensive books (>$25):")
    let expensiveBooks = books.filter { book in
        let price = book["price"] as? Int ?? 0
        return price > 25
    }
    for book in expensiveBooks {
        let title = book["title"] as? String ?? "Unknown"
        let price = book["price"] as? Int ?? 0
        print("• \(title) - $\(price)")
    }
    
    print("\n3. Using reduce to find the most expensive book:")
    let mostExpensive = books.reduce(books[0]) { current, book in
        let currentPrice = current["price"] as? Int ?? 0
        let bookPrice = book["price"] as? Int ?? 0
        return bookPrice > currentPrice ? book : current
    }
    let expensiveTitle = mostExpensive["title"] as? String ?? "Unknown"
    let expensivePrice = mostExpensive["price"] as? Int ?? 0
    print("• \(expensiveTitle) - $\(expensivePrice)")
    
    print("\n4. Using compactMap to get authors of classic books:")
    let classicAuthors = books.compactMap { book -> String? in
        guard let genres = book["genre"] as? [String],
              genres.contains("Classic"),
              let author = book["author"] as? String else { return nil }
        return author
    }
    print(classicAuthors.joined(separator: ", "))
    
    print("\n5. Using flatMap and reduce together:")
    let totalGenreCount = books.flatMap { book in
        return (book["genre"] as? [String]) ?? []
    }.reduce(0) { count, _ in count + 1 }
    print("Total genre instances: \(totalGenreCount)")
    
    print("\n6. Chaining multiple higher-order functions:")
    let modernProgrammingBookTitles = books
        .filter { book in
            let year = book["year"] as? Int ?? 0
            let genres = book["genre"] as? [String] ?? []
            return year > 2000 && genres.contains("Programming")
        }
        .compactMap { $0["title"] as? String }
    
    print("Modern programming books: \(modernProgrammingBookTitles.joined(separator: ", "))")
}

demonstrateResults()
demonstrateHigherOrderFunctions()
