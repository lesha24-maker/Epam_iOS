//
//  TextFileManager.swift
//  ApplicationBundle1
//
//  Created by Alexey Lim on 22/7/25.
//

import Foundation

class TextFileManager {
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
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
            
            print("File saved/updated successfully at: \(fileURL.path)")
            
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
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("Info: File '\(fileName)' does not exist yet.")
            return nil
        }
        
        do {
            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
            return savedText
        } catch {
            print("Error retrieving file: \(error.localizedDescription)")
            return nil
        }
    }
}
