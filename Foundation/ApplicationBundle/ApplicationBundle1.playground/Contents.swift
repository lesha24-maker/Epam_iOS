import UIKit

class TextFileManager {
    
    func getDocumentsDirectory() -> URL? {
        
        let fileManager = FileManager.default
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func saveText(_ text: String, to fileName: String) {
        guard let documentsDirectory = getDocumentsDirectory() else {
            print("Error: Could not find the Documents directory.")
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            
            var attributes = [FileAttributeKey: Any]()
            attributes[.protectionKey] = FileProtectionType.complete
            try FileManager.default.setAttributes(attributes, ofItemAtPath: fileURL.path)
            
            print("File saved successfully!")
            print("   -> at path: \(fileURL.path)")
            
        } catch {
            print("Error saving file: \(error.localizedDescription)")
        }
    }
    
    func retrieveText(from fileName: String) -> String? {
        guard let documentsDirectory = getDocumentsDirectory() else {
            print("Error: Could not find the Documents directory.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
            return savedText
        } catch {
            print("Error retrieving file: \(error.localizedDescription)")
            return nil
        }
    }
}

print("--- Starting File Management Test ---\n")

let manager = TextFileManager()

let mySecretMessage = "This demonstrates saving data securely within an app's sandbox. Only the app can access this."
let myFileName = "TeacherNote.txt"

print("STEP 1: Attempting to save text...")
manager.saveText(mySecretMessage, to: myFileName)

print("\n--------------------------------------\n")

print("STEP 2: Attempting to retrieve text...")
if let retrievedMessage = manager.retrieveText(from: myFileName) {
    print("Success! Retrieved Message:")
    print("   \"\(retrievedMessage)\"")
} else {
    print("Failed to retrieve message.")
}

print("\n--- Test Complete ---")
