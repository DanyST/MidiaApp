//
//  TestCoreDataStack.swift
//  MidiaTests
//
//  Created by Luis Herrera Lillo on 12-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//


import Foundation
import CoreData
@testable import Midia

final class CoreDataTestStack: CoreDataStackProvidable {
    
    let persistenceContainer: NSPersistentContainer
    
    init() {
        persistenceContainer = NSPersistentContainer(name: "Model")
        
        // save in volatil memory for tests
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false

        persistenceContainer.persistentStoreDescriptions = [description]

        persistenceContainer.loadPersistentStores { (storeDescription, error) in
            // Check if the data store is in memory
            precondition( storeDescription.type == NSInMemoryStoreType )
            
            if let error = error {
                fatalError("Error loading persistent stores \(error)")
            }
        }
    }

}
