//
//  BadgeManager.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/23.
//

final class BadgeManger: CoreDataManager {
    static let shared = BadgeManger()
    
    override private init() {}
    
    // MARK: - CRUD Func
    
    func initBadge() {
        guard let number = try? context.count(for: Badge.fetchRequest()), number == 0 else {
            return
        }
        
        context.perform {
            let newBadge = Badge(context: self.context)
            
            newBadge.coinsLeftForToday = 5
            newBadge.numberOfTotalCoins = 0
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
            
            let todaysCoin = Int(currentBadge.coinsLeftForToday)
            
            if todaysCoin > 0 {
                currentBadge.setValue(todaysCoin - 1, forKey: "coinsLeftForToday")
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
            
            let todaysCoin = Int(currentBadge.coinsLeftForToday)
            let totalCoin = Int(currentBadge.numberOfTotalCoins)
            
            currentBadge.setValue(totalCoin + todaysCoin, forKey: "numberOfTotalCoins")
            
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
            
            currentBadge.setValue(5, forKey: "coinsLeftForToday")
            
            saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    
    func numberOfTotalCoins() -> (result: Int, error: Int) {
        let request = Badge.fetchRequest()
        
        var totalCoins: Int!
        
        do {
            let results = try context.fetch(request)
            
            guard let allBadges = results.first else {
                return (0, 0)
            }
            
            totalCoins = Int(allBadges.numberOfTotalCoins)
        } catch {
            fatalError("\(error)")
        }
        
        return (totalCoins, 1)
    }
    
    func coinsLeftForToday() -> (result: Int, error: Int) {
        let request = Badge.fetchRequest()
        
        var todaysCoins: Int!
        
        do {
            let results = try context.fetch(request)
            
            guard let allBadges = results.first else {
                return (0, 0)
            }
            
            todaysCoins = Int(allBadges.coinsLeftForToday)
        } catch {
            fatalError("\(error)")
        }
        
        return (todaysCoins, 1)
    }
    
    func allBadges() -> (result: (numberOfTotalCoins: Int, coinsLeftForToday: Int), error: Int) {
        let request = Badge.fetchRequest()
        
        var totalCoins: Int!
        var todaysCoins: Int!
        
        do {
            let results = try context.fetch(request)
            
            guard let allBadges = results.first else {
                return ((0, 0), 0)
            }
            
            totalCoins = Int(allBadges.numberOfTotalCoins)
            todaysCoins = Int(allBadges.coinsLeftForToday)
        } catch {
            fatalError("\(error)")
        }
        
        return ((totalCoins, todaysCoins), 1)
    }
    
    func deleteBadges() {
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
