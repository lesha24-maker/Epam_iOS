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
    nonisolated(unsafe) static var studentCount: Int = 0
    weak var advisor: Professor?
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }

    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        Student.studentCount += 1
        print("LOG: Student (required) initialized: \(self.name), \(formattedID). Total students: \(Student.studentCount)")
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
        print("LOG: Student \(name) (\(studentID)) is being deinitialized. Current student count (before this deinit affects it, if it did): \(Student.studentCount)")
    }
}

class Professor: Person {
    let faculty: String
    nonisolated(unsafe) static var professorCount: Int = 0
    var fullTitle: String {
        return "Prof. \(name), \(faculty) Department"
    }

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        Professor.professorCount += 1
        print("LOG: Professor initialized: \(self.fullTitle). Total professors: \(Professor.professorCount)")
    }

    override func describe() -> String {
        return "\(super.describe()), Title: \(fullTitle)"
    }
    
    deinit {
        print("LOG: Professor \(name) from \(faculty) is being deinitialized. Current professor count (before this deinit affects it, if it did): \(Professor.professorCount)")
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
