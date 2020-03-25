//
//  DataProvider.swift
//  Network
//
//  Created by Kira on 22.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import CoreData

class PostsDataProvider {
    
    //MARK: - Variables
    static let entityName = "Post"
    private let persistentContainer: NSPersistentContainer
    private let networkManager: NetworkManager
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(persistentContainer: NSPersistentContainer, networkManager: NetworkManager) {
        self.persistentContainer = persistentContainer
        self.networkManager = networkManager
    }
    
    public func fetchPosts(completion: @escaping(Bool, String?) -> Void) {
        networkManager.getPots { posts, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let posts = posts else {
                completion(false, "Posts are underfined.")
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
            taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            taskContext.undoManager = nil
            
            let result = self.syncPosts(posts: posts, taskContext: taskContext)
            
            completion(result, nil)
        }
    }
    
    public func sendNewPost(postData: PostRequest, complection: @escaping(Int?, String?) -> Void) {
        networkManager.addPost(body: postData) { (postResponse, error) in
            if let error = error {
                complection(nil, error)
                return
            }
            
            guard var post = postResponse else {
                complection(nil, "Adding post is not success.")
                return
            }
            
            let taskContext = self.persistentContainer.newBackgroundContext()
                 taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                 taskContext.undoManager = nil
            
            post.body = postData.body
            post.title = postData.title
            post.userId = postData.userId
            
            if self.syncPosts(posts: [post], taskContext: taskContext) {
                DispatchQueue.main.async {
                    complection(post.id, nil)
                }
                return
            }
            
            complection(nil, "Post was added, but didn't save.")
        }
    }
    
    private func syncPosts(posts: [PostResponse], taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
            let matchingPostRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PostsDataProvider.entityName)
            let postIds = posts.map { $0.id }.compactMap { $0 }
            matchingPostRequest.predicate = NSPredicate(format: "id in %@", argumentArray: [postIds])
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingPostRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            // Execute the request to de batch delete and merge the changes to viewContext, which triggers the UI update
            do {
                let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
                
                if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                    NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                        into: [self.persistentContainer.viewContext])
                }
            } catch {
                print("Error: \(error)\nCould not batch delete existing records.")
                return
            }
            
            // Create new records.
            
            posts.forEach { post in
                guard let postManagedObject = NSEntityDescription.insertNewObject(forEntityName: PostsDataProvider.entityName, into: taskContext) as? PostManagedObject else {
                    print("Error: Failed to create a new Post object!")
                    return
                }
                
                do {
                    try postManagedObject.update(with: post.dictionary)
                } catch {
                    print("Error: \(error)\nThe post object will be deleted.")
                    taskContext.delete(postManagedObject)
                }
            }
            
            // Save all the changes just made and reset the taskContext to free the cache.
            if taskContext.hasChanges {
                do {
                    try taskContext.save()
                } catch {
                    print("Error: \(error)\nCould not save Core Data context.")
                }
                taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
            }
            successfull = true
        }
        return successfull
    }
}
