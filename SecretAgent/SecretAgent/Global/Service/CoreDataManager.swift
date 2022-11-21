//
//  CoreDataManager.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/21.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SecretAgent")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

extension CoreDataManager {
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CRUD Func
    
    func initBadge() {
        guard let number = try? context.count(for: Badge.fetchRequest()), number == 0 else {
            return
        }
        
        context.perform {
            let newBadge = Badge(context: self.context)
            
            newBadge.numberOfTodaysCoin = 0
            newBadge.numberOfTotalCoin = 0
            self.saveContext()
        }
    }
    
    func decreaseTodaysBadge() {
        let request = Badge.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            guard let currentBadge = results.first else {
                return
            }
            
            let todaysCoin = Int(currentBadge.numberOfTodaysCoin)
            
            if todaysCoin < 0 {
                currentBadge.setValue(todaysCoin - 1, forKey: "todaysCoin")
            } else {}
            
            saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    
    func updateTotalBadge() {
        let request = Badge.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            guard let currentBadge = results.first else {
                return
            }
            
            let todaysCoin = Int(currentBadge.numberOfTodaysCoin)
            let totalCoin = Int(currentBadge.numberOfTotalCoin)
            
            currentBadge.setValue(totalCoin + todaysCoin, forKey: "totalCoin")
            
            saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    
    func resetTodaysBadge() {
        let request = Badge.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            guard let currentBadge = results.first else {
                return
            }
            
            currentBadge.setValue(5, forKey: "todaysCoin")
            
            saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    
    func fetchBadge() {
        let request = Badge.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            print(results.count)
            
            guard let allBadges = results.first else {
                return
            }
            
            print("totalCoin", allBadges.numberOfTotalCoin)
            print("todaysCoin", allBadges.numberOfTodaysCoin)
            
            saveContext()
        } catch {}
    }
    
    func deleteBadge() {
        let request = Badge.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            
            for result in results {
                context.delete(result)
            }
            
            saveContext()
        } catch {}
    }
}
