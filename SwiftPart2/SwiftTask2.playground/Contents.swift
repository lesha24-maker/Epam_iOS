import Foundation

class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("Person initialized: \(name), age \(age)")
    }
    
    init?(name: String, age: Int, minimumAge: Int = 16) {
        guard age >= minimumAge else {
            print("Failed to initialize Person: Age \(age) is below minimum age of \(minimumAge)")
            return nil
        }
        self.name = name
        self.age = age
        print("Person initialized (failable): \(name), age \(age)")
    }
    
    func displayInfo() {
        print("Name: \(name), Age: \(age)")
    }
}

class Student: Person {
    let studentID: String
    let major: String
    
    required override init(name: String, age: Int) {
        self.studentID = "STU" + String(Int.random(in: 1000...9999))
        self.major = "Undeclared"
        super.init(name: name, age: age)
        print("Student initialized (required): ID \(studentID), Major: \(major)")
    }
    
    init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        print("Student initialized (designated): ID \(studentID), Major: \(major)")
    }
    
    convenience init(name: String, age: Int, major: String) {
        let generatedID = "STU" + String(Int.random(in: 1000...9999))
        self.init(name: name, age: age, studentID: generatedID, major: major)
        print("Student initialized (convenience): Auto-generated ID")
    }
    
    required override init?(name: String, age: Int, minimumAge: Int = 18) {
        guard age >= minimumAge else {
            print("Failed to initialize Student: Age \(age) is below minimum student age of \(minimumAge)")
            return nil
        }
        self.studentID = "STU" + String(Int.random(in: 1000...9999))
        self.major = "Undeclared"
        super.init(name: name, age: age)
        print("Student initialized (required failable): ID \(studentID)")
    }
    
    override func displayInfo() {
        super.displayInfo()
        print("Student ID: \(studentID), Major: \(major)")
    }
}

class Professor: Person {
    let faculty: String
    let employeeID: String
    
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        self.employeeID = "PROF" + String(Int.random(in: 100...999))
        super.init(name: name, age: age)
        print("Professor initialized: Faculty \(faculty), Employee ID: \(employeeID)")
    }
    
    convenience init(name: String, faculty: String) {
        self.init(name: name, age: 30, faculty: faculty)
        print("Professor initialized (convenience): Default age assigned")
    }
    
    init?(name: String, age: Int, faculty: String, minimumAge: Int = 25) {
        guard age >= minimumAge else {
            print("Failed to initialize Professor: Age \(age) is below minimum professor age of \(minimumAge)")
            return nil
        }
        self.faculty = faculty
        self.employeeID = "PROF" + String(Int.random(in: 100...999))
        super.init(name: name, age: age)
        print("Professor initialized (failable): Faculty \(faculty)")
    }
    
    override func displayInfo() {
        super.displayInfo()
        print("Faculty: \(faculty), Employee ID: \(employeeID)")
    }
}

struct University {
    let name: String
    let location: String
    
    func displayInfo() {
        print("University: \(name), Location: \(location)")
    }
}

struct Course {
    let courseCode: String
    let courseName: String
    let credits: Int
    let professor: Professor?
    
    init(courseCode: String, courseName: String, credits: Int = 3, professor: Professor? = nil) {
        self.courseCode = courseCode
        self.courseName = courseName
        self.credits = credits
        self.professor = professor
        print("Course initialized: \(courseCode) - \(courseName) (\(credits) credits)")
    }
}

print("=== University Student Management System ===\n")

print("1. Creating University (using memberwise initializer):")
let university = University(name: "Swift University", location: "San Francisco, CA")
university.displayInfo()

print("\n2. Testing Person class initializers:")
let person1 = Person(name: "John Doe", age: 20)
person1.displayInfo()

let person2 = Person(name: "Jane Smith", age: 15, minimumAge: 16)
if person2 == nil {
    print("Person2 failed to initialize as expected")
}

print("\n3. Testing Student class initializers:")
let student1 = Student(name: "Alice Johnson", age: 19)

let student2 = Student(name: "Bob Wilson", age: 21, studentID: "STU2024001", major: "Computer Science")

let student3 = Student(name: "Carol Brown", age: 20, major: "Mathematics")

let student4 = Student(name: "David Lee", age: 17, minimumAge: 18)
if student4 == nil {
    print("Student4 failed to initialize as expected")
}

print("\n4. Testing Professor class initializers:")
let professor1 = Professor(name: "Dr. Smith", age: 35, faculty: "Engineering")

let professor2 = Professor(name: "Dr. Johnson", faculty: "Mathematics")

let professor3 = Professor(name: "Dr. Young", age: 23, faculty: "Physics", minimumAge: 25)
if professor3 == nil {
    print("Professor3 failed to initialize as expected")
}

print("\n5. Creating courses:")
let course1 = Course(courseCode: "CS101", courseName: "Introduction to Programming", professor: professor1)
let course2 = Course(courseCode: "MATH201", courseName: "Calculus II", credits: 4, professor: professor2)

print("\n6. Displaying all information:")
print("\n--- University Info ---")
university.displayInfo()

print("\n--- Students ---")
student1.displayInfo()
print()
student2.displayInfo()
print()
student3.displayInfo()

print("\n--- Professors ---")
professor1.displayInfo()
print()
professor2.displayInfo()

print("\n=== End of Demo ===")
