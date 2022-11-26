//
//  CoreDataManager.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/21.
//

import CoreData

class CoreDataManager {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SecretAgent")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("\(error)")
            }
        }
    }
}
