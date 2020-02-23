//
//  FileManagerStorage.swift
//  StorageTypes
//
//  Created by Kira on 20.02.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation

class FileManagerStorage<T: StorageKeys>: StorageProtocol {
    
    typealias storageKeys = T
    let fileManager = FileManager()
    let tempDir = NSTemporaryDirectory()
    let fileExt = "txt"
    
    func setWith(key: storageKeys, value: Any) {
        guard let data = value as? String else { return }
        let path = (tempDir as NSString).appendingPathComponent("\(key.rawValue).\(fileExt)")
        
        do {
            try data.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("could't create file text.txt because of error: \(error)")
        }
    }
    
    func getBy(key: storageKeys) -> Any? {
        let directoryWithFiles = checkDirectoryOf(fileName: key.rawValue) ?? "Empty"
        let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)

        do {
            let contentsOfFile = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            return contentsOfFile
        } catch _ as NSError {
            return nil
        }
    }
    
    func removeBy(key: storageKeys) {
        let directoryWithFiles = checkDirectoryOf(fileName: key.rawValue) ?? "Empty"
        do {
            let path = (tempDir as NSString).appendingPathComponent(directoryWithFiles)
            try fileManager.removeItem(atPath: path)
            print("file deleted")
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
    }
    
    func clearAll() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try fileManager.contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try fileManager.removeItem(atPath: fileUrl.path)
            }
        } catch let error as NSError {
            print("there is an file reading error: \(error)")
        }
    }
    
    func checkDirectoryOf(fileName: String) -> String? {
        do {
            let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDir)
            let files = filesInDirectory
            var searchingFile: String?
            
            if files.count > 0 {
                files.forEach { file in
                    if file == "\(fileName).\(fileExt)" {
                        searchingFile = file
                    }
                }
            }
            
            return searchingFile
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
