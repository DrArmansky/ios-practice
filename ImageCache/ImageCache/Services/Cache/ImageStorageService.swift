//
//  ImageStorage.swift
//  ImageCache
//
//  Created by Kira on 08.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import UIKit

enum StorageError: Error {
    case invalidImage
}

final class ImageStorageService {
    
    private let fileExt = "png"
    
    private let fileManager = FileManager()
    private let documentDirectory: URL
    private let filesPath: URL
    
    static let defaultDirectoryName = "ImageCache"
    
    init(directoryName: String?) throws {
        documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let directory = directoryName != nil ? directoryName! : ImageStorageService.defaultDirectoryName
        filesPath = documentDirectory.appendingPathComponent(directory)
        
        try fileManager.createDirectory(at: filesPath, withIntermediateDirectories: true)
    }
    
    func set(image: UIImage, forKey key: String) throws -> String {
        guard let data = image.pngData() else {
            throw StorageError.invalidImage
        }
        
        if let filePath = makeFilePath(for: key) {
            return filePath
        }
        
        let filePath = filesPath.appendingPathComponent("\(key).\(fileExt)")
        fileManager.createFile(atPath: filePath.path, contents: data, attributes: nil)
        
        return filePath.path
    }
    
    func get(forKey key: String) throws -> UIImage {
        let path = makeFilePath(for: key)
        guard let filePath = path else {
            throw StorageError.invalidImage
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        guard let image = UIImage(data: data) else {
            throw StorageError.invalidImage
        }
        
        return image
    }
    
    static func getAll(directoryName: String?) -> [UIImage] {
        do {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directory = directoryName != nil ? directoryName! : ImageStorageService.defaultDirectoryName
            let filesPath = documentDirectory.appendingPathComponent(directory)
            
            let files = try FileManager.default.contentsOfDirectory(at: filesPath, includingPropertiesForKeys: nil)
            var imageList: [UIImage] = []
            if files.count == 0 {
                return imageList
            }
            
            try files.forEach { path in
                let data = try Data(contentsOf: path)
                if let image = UIImage(data: data) {
                    imageList.append(image)
                }
            }
            
            return imageList
            
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    private func makeFilePath(for fileName: String) -> String? {
        do {
            let files = try fileManager.contentsOfDirectory(atPath: filesPath.path)
            if files.count == 0 {
                return nil
            }
            var searchFilePath: String?
            
            files.forEach { name in
                if name == "\(fileName).\(fileExt)" {
                    searchFilePath = "\(filesPath.path)/\(name)"
                }
            }
            
            return searchFilePath
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
}
