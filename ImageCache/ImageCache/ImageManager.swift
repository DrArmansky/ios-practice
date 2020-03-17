//
//  ImageManager.swift
//  ImageCache
//
//  Created by Kira on 11.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import UIKit

enum ImageManagerError: Error {
    case imageStorageUndefined
    case wrongUrl
}

class ImageManager {
    private var imageStorage = try? ImageStorageService(directoryName: nil)
    private let imageNetwork = ImageNetworkService()
    private var responseImagesData: [ImageResponseModel]?
    private let defaultImageQuantity = 10
    
    var images: [UIImage] = []
    
    public func getList(completion: @escaping ([UIImage]?) -> ()) {
        do {
            if imageStorage == nil {
                throw ImageManagerError.imageStorageUndefined
            }
            DispatchQueue.global(qos: .utility).async {
                self.images = ImageStorageService.getAll(directoryName: nil)
                if self.images.count == 0 {
                    self.downloadIn(quantity: self.defaultImageQuantity, completion: completion)
                    return
                }
                
                completion(self.images)
            }
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func downloadIn(quantity:Int, completion: @escaping ([UIImage]?) -> ()) {
        let semaphore = DispatchSemaphore(value: 0)
        
        imageNetwork.getData { [weak self] (imagesData, error) in
            if let error = error {
                print(error)
                semaphore.signal()
                return
            }
            
            guard let clippedImagesData = imagesData?.prefix(quantity), clippedImagesData.count > 0 else {
                semaphore.signal()
                return
            }
            let imageModels = Array(clippedImagesData)
            
            imageModels.forEach { imageModel in
                self?.downloadImageBy(imageModel) { image in
                    self?.images.append(image!)
                    
                    if
                        let index = imageModels.firstIndex(of: imageModel),
                        index == imageModels.endIndex - 1
                    {
                        semaphore.signal()
                    }
                }
            }
            
        }
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        
        completion(images)
    }
    
    public func downloadImageBy(_ model: ImageResponseModel, completion: @escaping (UIImage?) -> ()) {
        guard let imageURL = URL(string: model.url) else { return }
        
        self.imageNetwork.download(url: imageURL) { [weak self] (downloadedImage, error)  in
            if let error = error {
                print(error)
                return
            }
            
            guard let image: UIImage = downloadedImage else { return }
            _ = try? self?.imageStorage?.set(image: image, forKey: imageURL.lastPathComponent)
            
            completion(image)
        }
    }
}
