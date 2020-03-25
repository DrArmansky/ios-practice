//
//  PostManagedObject.swift
//  Network
//
//  Created by Kira on 22.03.2020.
//  Copyright © 2020 Kira. All rights reserved.
//

import CoreData

class PostManagedObject: NSManagedObject {
    
    //MARK:- Variables
    @NSManaged var userId: NSNumber
    @NSManaged var title: String
    @NSManaged var id: NSNumber
    @NSManaged var body: String
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard
            let userId = jsonDictionary["userId"] as? Int,
            let title = jsonDictionary["title"] as? String,
            let id = jsonDictionary["id"] as? Int,
            let body = jsonDictionary["body"] as? String
            else {
                throw NSError(domain: "", code: 100, userInfo: nil)
        }
        
        self.userId = NSNumber(value: userId)
        self.title = title
        self.id = NSNumber(value: id)
        self.body = body
    }
}
