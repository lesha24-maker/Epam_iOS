import Foundation

struct School {

    enum SchoolRole: String, CaseIterable {
        case student = "Student"
        case teacher = "Teacher"
        case administrator = "Administrator"
        
        var description: String {
            return self.rawValue
        }
    }
    
    class Person {
        let name: String
        let role: SchoolRole
        
        init(name: String, role: SchoolRole) {
            self.name = name
            self.role = role
        }
        
        var description: String {
            return "\(name) - \(role.description)"
        }
    }
    
    private var people: [Person] = []
    
    mutating func addPerson(_ person: Person) {
        people.append(person)
    }
    
    mutating func addPerson(name: String, role: SchoolRole) {
        let person = Person(name: name, role: role)
        addPerson(person)
    }
    
    func getAllPeople() -> [Person] {
        return people
    }
    
    mutating func removePerson(named name: String) -> Bool {
        if let index = people.firstIndex(where: { $0.name == name }) {
            people.remove(at: index)
            return true
        }
        return false
    }
    
    subscript(role: SchoolRole) -> [Person] {
        return people.filter { $0.role == role }
    }
    
    subscript(index: Int) -> Person? {
        guard index >= 0 && index < people.count else { return nil }
        return people[index]
    }
    
    subscript(name: String) -> Person? {
        return people.first { $0.name == name }
    }
}

func countStudents(in school: School) -> Int {
    return school[.student].count
}

func countTeachers(in school: School) -> Int {
    return school[.teacher].count
}

func countAdministrators(in school: School) -> Int {
    return school[.administrator].count
}

func printSchoolRoster(_ school: School) {
    print("=== SCHOOL ROSTER ===")
    
    for role in School.SchoolRole.allCases {
        let people = school[role]
        print("\n\(role.description)s (\(people.count)):")
        if people.isEmpty {
            print("  - None")
        } else {
            for person in people {
                print("  - \(person.name)")
            }
        }
    }
    print("\nTotal People: \(school.getAllPeople().count)")
}

func getSchoolStatistics(_ school: School) -> (students: Int, teachers: Int, administrators: Int, total: Int) {
    let students = countStudents(in: school)
    let teachers = countTeachers(in: school)
    let administrators = countAdministrators(in: school)
    let total = students + teachers + administrators
    
    return (students, teachers, administrators, total)
}


func demonstrateSchoolSystem() {
    print("=== SCHOOL MANAGEMENT SYSTEM DEMO ===\n")
    
    var mySchool = School()
    
    print("1. Adding people to the school...")
    
    mySchool.addPerson(name: "Alice Johnson", role: .student)
    mySchool.addPerson(name: "Bob Smith", role: .student)
    mySchool.addPerson(name: "Charlie Brown", role: .student)
    mySchool.addPerson(name: "Diana Prince", role: .student)
    
    mySchool.addPerson(name: "Prof. Emily Davis", role: .teacher)
    mySchool.addPerson(name: "Dr. Michael Wilson", role: .teacher)
    mySchool.addPerson(name: "Ms. Sarah Connor", role: .teacher)
    
    mySchool.addPerson(name: "Principal John Adams", role: .administrator)
    mySchool.addPerson(name: "Vice Principal Jane Doe", role: .administrator)
    
    let newStudent = School.Person(name: "Eva Martinez", role: .student)
    mySchool.addPerson(newStudent)
    
    print("✅ Added 10 people to the school\n")
    
    print("2. Testing subscripts...")
    
    let students = mySchool[.student]
    let teachers = mySchool[.teacher]
    let administrators = mySchool[.administrator]
    
    print("Students found: \(students.count)")
    print("Teachers found: \(teachers.count)")
    print("Administrators found: \(administrators.count)\n")
    
    if let person = mySchool["Alice Johnson"] {
        print("Found person: \(person.description)")
    }
    
    if let firstPerson = mySchool[0] {
        print("First person in school: \(firstPerson.description)\n")
    }
    
    print("3. Using counting functions...")
    
    let studentCount = countStudents(in: mySchool)
    let teacherCount = countTeachers(in: mySchool)
    let adminCount = countAdministrators(in: mySchool)
    
    print("📊 School Statistics:")
    print("   Students: \(studentCount)")
    print("   Teachers: \(teacherCount)")
    print("   Administrators: \(adminCount)")
    print("   Total: \(studentCount + teacherCount + adminCount)\n")
    
    print("4. Detailed school roster:")
    printSchoolRoster(mySchool)
    
    print("\n5. Testing person removal...")
    let removed = mySchool.removePerson(named: "Bob Smith")
    print("Removed Bob Smith: \(removed)")
    
    print("\n6. Updated statistics after removal:")
    let stats = getSchoolStatistics(mySchool)
    print("📊 Updated Statistics:")
    print("   Students: \(stats.students)")
    print("   Teachers: \(stats.teachers)")
    print("   Administrators: \(stats.administrators)")
    print("   Total: \(stats.total)")
    
    print("\n7. Testing different ways to access data...")
    
    print("All students:")
    for student in mySchool[.student] {
        print("  - \(student.name)")
    }
    
    print("\nAll teachers:")
    for teacher in mySchool[.teacher] {
        print("  - \(teacher.name)")
    }
    
    print("\nAll administrators:")
    for admin in mySchool[.administrator] {
        print("  - \(admin.name)")
    }
    
    print("\n=== DEMO COMPLETED ===")
}

// MARK: - Extended Features Demo

func demonstrateAdvancedFeatures() {
    print("\n=== ADVANCED FEATURES DEMO ===\n")
    
    var school = School()
    
    let peopleToAdd = [
        ("John Doe", School.SchoolRole.student),
        ("Jane Smith", School.SchoolRole.teacher),
        ("Bob Johnson", School.SchoolRole.administrator),
        ("Alice Brown", School.SchoolRole.student),
        ("Charlie Wilson", School.SchoolRole.teacher)
    ]
    
    for (name, role) in peopleToAdd {
        school.addPerson(name: name, role: role)
    }
    
    print("Added \(peopleToAdd.count) people to school\n")
    
    print("Available roles in the school system:")
    for role in School.SchoolRole.allCases {
        let count = school[role].count
        print("  - \(role.description): \(count) people")
    }
    
    print("\nDemonstrating type safety with nested types...")
    let exampleRole: School.SchoolRole = .teacher
    print("Selected role: \(exampleRole.description)")
    print("People with this role: \(school[exampleRole].map { $0.name }.joined(separator: ", "))")
    
    print("\n=== ADVANCED DEMO COMPLETED ===")
}

demonstrateSchoolSystem()
demonstrateAdvancedFeatures()
