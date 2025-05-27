import Foundation

extension String {
    func simpleHash() -> String {
        return "hashed_\(self.reversed())_example"
    }
}

struct User {
    let username: String
    let email: String
    let password: String
    
    init(username: String, email: String, hashedPassword: String) {
        self.username = username
        self.email = email
        self.password = hashedPassword
    }
}

class UserManager {
    var users: [String: User] = [:]

    init() {
        print("UserManager instance initialized.")
    }

    func registerUser(username: String, email: String, password: String) -> Bool {
        guard users[username] == nil else {
            print("Registration failed: Username '\(username)' already exists.")
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            print("Registration failed: Invalid email format for '\(email)'.")
            return false
        }

        let hashedPassword = password.simpleHash()
        
        let newUser = User(username: username, email: email, hashedPassword: hashedPassword)
        users[username] = newUser
        print("User '\(username)' registered successfully.")
        return true
    }

    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("Login failed: User '\(username)' not found.")
            return false
        }

        let hashedInputPassword = password.simpleHash()

        if user.password == hashedInputPassword {
            print("User '\(username)' logged in successfully.")
            return true
        } else {
            print("Login failed: Incorrect password for user '\(username)'.")
            return false
        }
    }

    func removeUser(username: String) -> Bool {
        if users.removeValue(forKey: username) != nil {
            print("User '\(username)' removed successfully.")
            return true
        } else {
            print("Removal failed: User '\(username)' not found.")
            return false
        }
    }

    var userCount: Int {
        return users.count
    }
    
    deinit {
        print("UserManager instance deinitialized.")
    }
}

class AdminUser: UserManager {
    
    override init() {
        super.init()
        print("AdminUser instance initialized.")
    }

    func listAllUsers() -> [String] {
        return Array(users.keys.sorted())
    }

    deinit {
        print("AdminUser instance is being deinitialized. Admin has left the building. Users managed: \(userCount).")
    }
}
