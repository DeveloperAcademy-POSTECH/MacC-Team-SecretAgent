//
//  BadgeManager.swift
//  SecretAgent
//
//  Created by JiwKang on 2022/11/23.
//

final class BadgeManager: CoreDataManager {
    static let shared = BadgeManager()
    
    override private init() {}
    
    func fetchBadge() throws -> [Badge] {
        let request = Badge.fetchRequest()
        let results = try context.fetch(request)
        
        return results
    }
    
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
    
    func decreaseTodaysBadge() throws {
        let results = try fetchBadge()
        let currentBadge = results.first
        let todaysCoin = Int(currentBadge?.coinsLeftForToday ?? 5)
        
        if todaysCoin > 0 {
            currentBadge?.setValue(todaysCoin - 1, forKey: "coinsLeftForToday")
        }
        
        saveContext()
    }
    
    func updateTotalBadge() throws {
        let results = try fetchBadge()
        let currentBadge = results.first
        let todaysCoin = Int(currentBadge?.coinsLeftForToday ?? 5)
        let totalCoin = Int(currentBadge?.numberOfTotalCoins ?? 0)
        
        currentBadge?.setValue(totalCoin + todaysCoin, forKey: "numberOfTotalCoins")
        
        saveContext()
    }
    
    func testUpdateTotalBadge() throws {
        let results = try fetchBadge()
        let currentBadge = results.first
        let todaysCoin = Int(currentBadge?.coinsLeftForToday ?? 5)
        let totalCoin = Int(currentBadge?.numberOfTotalCoins ?? 0)
        
        currentBadge?.setValue(totalCoin - todaysCoin, forKey: "numberOfTotalCoins")
        
        saveContext()
    }
    
    func resetTodaysBadge() throws {
        let results = try fetchBadge()
        let currentBadge = results.first
        
        currentBadge?.setValue(5, forKey: "coinsLeftForToday")
        
        saveContext()
    }
    
    func numberOfTotalCoins() throws -> (result: Int, error: Int) {
        let results = try fetchBadge()
        var totalCoins: Int!
        let allBadges = results.first
        
        totalCoins = Int(allBadges?.numberOfTotalCoins ?? 0)
        
        return (totalCoins, 1)
    }
    
    func coinsLeftForToday() throws -> (result: Int, error: Int) {
        let results = try fetchBadge()
        var todaysCoins: Int!
        let allBadges = results.first

        todaysCoins = Int(allBadges?.coinsLeftForToday ?? 5)
        
        return (todaysCoins, 1)
    }
    
    func allBadges() throws -> (result: (numberOfTotalCoins: Int, coinsLeftForToday: Int), error: Int) {
        let results = try fetchBadge()
        var totalCoins: Int!
        var todaysCoins: Int!
        let allBadges = results.first
        
        totalCoins = Int(allBadges?.numberOfTotalCoins ?? 0)
        todaysCoins = Int(allBadges?.coinsLeftForToday ?? 5)
        
        return ((totalCoins, todaysCoins), 1)
    }
    
    func deleteBadges() throws {
        let results = try fetchBadge()
        
        for result in results {
            context.delete(result)
        }
        
        saveContext()
    }
}
