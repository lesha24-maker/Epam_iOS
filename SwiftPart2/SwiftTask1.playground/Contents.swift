import Foundation

struct User {
    let username: String
    let email: String
    private let hashedPassword: String
    
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.hashedPassword = User.hashPassword(password)
    }
    
    private static func hashPassword(_ password: String) -> String {
        return String(password.hashValue)
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return hashedPassword == User.hashPassword(password)
    }
}

class UserManager {
    var users: [String: User] = [:]
    
    init() {
        print("UserManager initialized")
    }
    
    func registerUser(username: String, email: String, password: String) -> Bool {
        guard !users.keys.contains(username) else {
            print("Registration failed: Username '\(username)' already exists")
            return false
        }
        
        guard isValidEmail(email) else {
            print("Registration failed: Invalid email format")
            return false
        }
        
        guard isValidPassword(password) else {
            print("Registration failed: Password must be at least 6 characters")
            return false
        }
        
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        print("User '\(username)' registered successfully")
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("Login failed: User '\(username)' not found")
            return false
        }
        
        if user.verifyPassword(password) {
            print("Login successful: Welcome, \(username)!")
            return true
        } else {
            print("Login failed: Invalid password for '\(username)'")
            return false
        }
    }
    
    func removeUser(username: String) -> Bool {
        guard users[username] != nil else {
            print("Removal failed: User '\(username)' not found")
            return false
        }
        
        users.removeValue(forKey: username)
        print("User '\(username)' removed successfully")
        return true
    }
    
    var userCount: Int {
        return users.count
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
}

class AdminUser: UserManager {
    private let adminName: String
    
    init(adminName: String) {
        self.adminName = adminName
        super.init()
        print("AdminUser '\(adminName)' initialized with elevated privileges")
    }
    
    func listAllUsers() -> [String] {
        let usernames = Array(users.keys).sorted()
        print("Total users (\(userCount)): \(usernames.joined(separator: ", "))")
        return usernames
    }
    
    func getUserDetails(username: String) -> String? {
        guard let user = users[username] else {
            print("User '\(username)' not found")
            return nil
        }
        return "Username: \(user.username), Email: \(user.email)"
    }
    
    func resetUserPassword(username: String, newPassword: String) -> Bool {
        guard users[username] != nil else {
            print("Password reset failed: User '\(username)' not found")
            return false
        }
        
        guard isValidPassword(newPassword) else {
            print("Password reset failed: Password must be at least 6 characters")
            return false
        }
        
        let user = users[username]!
        let updatedUser = User(username: user.username, email: user.email, password: newPassword)
        users[username] = updatedUser
        print("Password reset successful for user '\(username)'")
        return true
    }
    
    deinit {
        print("AdminUser '\(adminName)' is being removed from memory")
    }
}

let userManager = UserManager()
userManager.registerUser(username: "john_doe", email: "john@example.com", password: "password123")
userManager.registerUser(username: "jane_smith", email: "jane@example.com", password: "securepass")
userManager.registerUser(username: "bob_wilson", email: "bob@example.com", password: "mypassword")

print("\nCurrent user count: \(userManager.userCount)")

userManager.login(username: "john_doe", password: "password123")
userManager.login(username: "jane_smith", password: "wrongpassword")

var admin: AdminUser? = AdminUser(adminName: "admin_user")
admin?.registerUser(username: "alice_brown", email: "alice@example.com", password: "alicepass")

print("\nAdmin listing all users:")
admin?.listAllUsers()

admin?.getUserDetails(username: "john_doe")
admin?.resetUserPassword(username: "john_doe", newPassword: "newpassword456")
admin?.login(username: "john_doe", password: "newpassword456")

admin?.removeUser(username: "bob_wilson")
print("\nUser count after removal: \(admin?.userCount ?? 0)")

admin = nil
