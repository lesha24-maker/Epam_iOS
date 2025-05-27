import Foundation

class Person {
    let name: String
    let age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("Person (designated) initialized: \(self.name), Age: \(self.age)")
    }

    init?(name: String, validatingAge: Int) {
        guard validatingAge >= 16 else {
            print("Person initialization failed: Age \(validatingAge) is less than 16.")
            return nil
        }

        self.name = name
        self.age = validatingAge

        print("Person (failable) successfully initialized: \(self.name), Age: \(self.age)")
    }

    func describe() -> String {
        return "Name: \(name), Age: \(age)"
    }
}

class Student: Person {
    let studentID: String
    let major: String

    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        print("Student (required) initialized: \(self.name), ID: \(self.studentID), Major: \(self.major)")
    }
    
    convenience init(name: String, age: Int, studentID: String) {
        self.init(name: name, age: age, studentID: studentID, major: "Undeclared")
        print("Student (convenience) initialized for ID: \(self.studentID) with default major.")
    }

    override func describe() -> String {
        return "\(super.describe()), Student ID: \(studentID), Major: \(major)"
    }
}

class Professor: Person {
    let faculty: String

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        print("Professor initialized: \(self.name), Faculty: \(self.faculty)")
    }

    override func describe() -> String {
        return "\(super.describe()), Faculty: \(faculty)"
    }
}

struct University {
    let name: String
    let location: String

    func displayInfo() {
        print("University: \(name), Location: \(location)")
    }
}
