import Foundation

class Person {
    let name: String
    let age: Int
    static let minAgeForEnrollment: Int = 16
    var isAdult: Bool {
        return age >= 18
    }
    lazy var profileDescription: String = {
        print("LOG: Computing profileDescription for \(self.name)...")
        return "\(self.name) is \(self.age) years old."
    }()

    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("LOG: Person (designated) initialized: \(self.name), Age: \(self.age)")
    }

    init?(name: String, validatingAge: Int) {
        guard validatingAge >= Person.minAgeForEnrollment else {
            print("LOG: Person initialization failed: Age \(validatingAge) is less than min enrollment age (\(Person.minAgeForEnrollment)).")
            return nil
        }
        self.name = name
        self.age = validatingAge
        print("LOG: Person (failable) successfully initialized: \(self.name), Age: \(self.age)")
    }

    func describe() -> String {
        return "Name: \(name), Age: \(age), Adult: \(isAdult)"
    }
}

class Student: Person {
    let studentID: String
    let major: String
    
    private static let studentCountLock = NSLock()
    nonisolated(unsafe) private static var _studentCount: Int = 0

    static var studentCount: Int {
        get {
            studentCountLock.lock()
            defer { studentCountLock.unlock() }
            return _studentCount
        }
    }
    
    weak var advisor: Professor? 
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }

    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        
        Student.studentCountLock.lock()
        Student._studentCount += 1
        let currentTotal = Student._studentCount
        Student.studentCountLock.unlock()
        
        print("LOG: Student (required) initialized: \(self.name), \(formattedID). Total students: \(currentTotal)")
    }

    convenience init(name: String, age: Int, studentID: String) {
        self.init(name: name, age: age, studentID: studentID, major: "Undeclared")
        print("LOG: Student (convenience) initialized for \(formattedID) with default major.")
    }

    override func describe() -> String {
        let advisorName = advisor?.name ?? "None"
        return "\(super.describe()), \(formattedID), Major: \(major), Advisor: \(advisorName)"
    }

    deinit {
        print("LOG: Student \(name) (\(studentID)) is being deinitialized.")
    }
}

class Professor: Person {
    let faculty: String

    private static let professorCountLock = NSLock()
    nonisolated(unsafe) private static var _professorCount: Int = 0

    static var professorCount: Int {
        get {
            professorCountLock.lock()
            defer { professorCountLock.unlock() }
            return _professorCount
        }
    }
    
    var fullTitle: String {
        return "Prof. \(name), \(faculty) Department"
    }

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        
        Professor.professorCountLock.lock()
        Professor._professorCount += 1
        let currentTotal = Professor._professorCount
        Professor.professorCountLock.unlock()
        
        print("LOG: Professor initialized: \(self.fullTitle). Total professors: \(currentTotal)")
    }

    override func describe() -> String {
        return "\(super.describe()), Title: \(fullTitle)"
    }
    
    deinit {
        print("LOG: Professor \(name) from \(faculty) is being deinitialized.")
    }
}

struct University {
    let name: String
    let location: String
    var description: String {
        return "\(name) University, located in \(location)."
    }

    func displayInfo() {
        print(description)
    }
}

print("--- Initial Static Counts ---")
print("Initial student count: \(Student.studentCount)")
print("Initial professor count: \(Professor.professorCount)")
print("Minimum enrollment age (static from Person): \(Person.minAgeForEnrollment)")

print("\n--- Person Creation & Properties ---")
let skylerWhite = Person(name: "Skyler White", age: 40)
print(skylerWhite.describe())
print("Accessing lazy property 'profileDescription' for Skyler...")
print(skylerWhite.profileDescription)
print("Accessing lazy property 'profileDescription' for Skyler again...")
print(skylerWhite.profileDescription)

let hollyWhite = Person(name: "Holly White", validatingAge: 1)
if hollyWhite == nil {
    print("Holly White (age 1) could not be 'enrolled' due to age restriction (minAgeForEnrollment).")
}

let walterJr = Person(name: "Walter White Jr.", validatingAge: 17)
if let wj = walterJr {
    print("\(wj.name) (age \(wj.age)) created successfully. Is adult: \(wj.isAdult)")
}

print("\n--- Professor Creation & Properties ---")
var walterWhite: Professor? = Professor(name: "Walter White", age: 50, faculty: "Chemistry")
if let profWalt = walterWhite {
    print(profWalt.describe())
    print("Full title for Prof. Walter White: \(profWalt.fullTitle)")
}
let galeBoetticher = Professor(name: "Gale Boetticher", age: 34, faculty: "Organic Chemistry")
print("Professor Gale Boetticher's title: \(galeBoetticher.fullTitle)")

print("\n--- Student Creation & Properties ---")
var jessePinkman: Student? = Student(name: "Jesse Pinkman", age: 25, studentID: "JP001", major: "Applied Chemistry")
var badgerMayhew: Student? = Student(name: "Brandon 'Badger' Mayhew", age: 26, studentID: "BM002") // Undeclared major

if let jesse = jessePinkman {
    print(jesse.describe())
    print("Jesse's formatted ID: \(jesse.formattedID)")
    jesse.advisor = walterWhite
    print("Jesse's advisor after assignment: \(jesse.advisor?.name ?? "None")")
}

if let badger = badgerMayhew {
    print(badger.describe())
    print("Badger's formatted ID: \(badger.formattedID)")
    badger.advisor = galeBoetticher
    
    print("\n--- Current counts after creation ---")
    print("Current student count: \(Student.studentCount)")
    print("Current professor count: \(Professor.professorCount)")
    
    print("\n--- Weak Reference Demonstration (Advisor) ---")
    print("Jesse's advisor: \(jessePinkman?.advisor?.name ?? "None")")
    print("Setting Professor Walter White to nil (Walter 'retires')...")
    walterWhite = nil
    
    print("Jesse's advisor after Walter White is nil: \(jessePinkman?.advisor?.name ?? "None") (should be None due to weak reference)")
    
    if let badger = badgerMayhew {
        print("Badger's advisor: \(badger.advisor?.name ?? "None") (should still be Gale Boetticher)")
    }
    
    print("\n--- University Creation & Properties ---")
    let abqCommunityCollege = University(name: "ABQ Community College", location: "Albuquerque, NM")
    abqCommunityCollege.displayInfo()
    print("University's description property: \(abqCommunityCollege.description)")
    
    print("\n--- Deinitialization of remaining objects ---")
    print("Setting Jesse Pinkman to nil...")
    jessePinkman = nil
    print("Setting Badger Mayhew to nil...")
    badgerMayhew = nil
    
    print("\n--- End of Demo --- Yo! ---")
}
