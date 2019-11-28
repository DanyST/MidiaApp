//
//  CoreDataStorageManager.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 25-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import Foundation
import CoreData

// TODO: capa de abstraccion para usar siempre media items

final class CoreDataStorageManager: FavoritesProvidable {
    
    // MARK: - Properties
    let mediaItemKind: MediaItemKind
    let stack = CoreDataStack.sharedInstance
    
    // MARK: - Initialization
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
    }
    
    // MARK: - Methods
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        let context = stack.persistenceContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let dateSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: false)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
            
            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.map { $0.mappedObject() }
            } catch {
                assertionFailure("Error fetching media items") // assertionFailure solo funciona en debug
                return nil
            }
            
        default:
            fatalError("Not supported yet :(")
        }
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        let context = stack.persistenceContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let idPredicate = NSPredicate(format: "bookId = %@", favoriteId)  // id filter
            fetchRequest.predicate = idPredicate

            do {
                let favorites = try context.fetch(fetchRequest)
                return favorites.last?.mappedObject()
            } catch {
                assertionFailure("Error fetching media item by id \(favoriteId)") // assertionFailure solo funciona en debug
                return nil
            }
        default:
             fatalError("Not supported yet :(")
        }
       
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
        let context = stack.persistenceContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            
            // created BookManaged with mapping a media item book
            let _ = BookManaged(withMediaItemBook: favorite as! Book, context: context)
        default:
            fatalError("Not supported yet :(")
        }
        
        // Save changes
        do {
            try context.save()
        } catch {
            assertionFailure("Error saving context")
        }
        
    }
    
    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistenceContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            let idPredicate = NSPredicate(format: "bookId = %@", favoriteId)  // id filter
            fetchRequest.predicate = idPredicate

            do {
                let favorites = try context.fetch(fetchRequest)
                favorites.forEach { context.delete($0) }
                
                try context.save()
            } catch  {
                assertionFailure("Error saving media item with id \(favoriteId)")
            }
        default:
            fatalError("Not supported yet :(")
        }
       
    }
}
