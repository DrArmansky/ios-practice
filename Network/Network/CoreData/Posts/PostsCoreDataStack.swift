//
//  CoreDataStack.swift
//  Network
//
//  Created by Kira on 22.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import Foundation
import CoreData

class PostsCoreDataStack {
    
    //MARK:- Variables
    static let persistentContainerName = "Posts"
    
    private init() {}
    static let shared = PostsCoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: PostsCoreDataStack.persistentContainerName)
        
        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
}
