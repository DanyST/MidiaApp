//
//  CoreDataStack.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 25-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackProvidable {
    var persistenceContainer: NSPersistentContainer { get }
}


final class CoreDataStack: CoreDataStackProvidable {
    
    // Singleton
    static let sharedInstance = CoreDataStack()
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores \(error)")
            }
        }
        
        return container
    }()
    
}
