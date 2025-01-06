import Foundation
import CoreData

final class DataManager {
    private let modelName = "DataModel"
    
    lazy var coreDataStack = CoreDataStack(modelName: modelName)
    
    func save(_ goal: Goal) {
        let goalCD = GoalCD(context: coreDataStack.managedContext)
        goalCD.uuid = goal.uuid
        goalCD.idea = goal.idea
        goalCD.descr = goal.description
        goalCD.date = goal.date
        goalCD.endDate = goal.endDate
        coreDataStack.saveContext()
    }
    
    func save(_ consumption: Consumption) {
        let consumptionCD = ConsumptionCD(context: coreDataStack.managedContext)
        consumptionCD.uuid = consumption.uuid
        consumptionCD.quantity = Int32(consumption.quantity)
        consumptionCD.name = consumption.name
        consumptionCD.date = consumption.date
        consumptionCD.term = consumption.term
        coreDataStack.saveContext()
    }
    
    func save(_ price: Price) {
        let priceCD = PriceCD(context: coreDataStack.managedContext)
        priceCD.uuid = price.uuid
        priceCD.name = price.name
        priceCD.descr = price.description
        priceCD.date = price.date
        priceCD.price = price.price
        priceCD.benefit = price.benefit
        coreDataStack.saveContext()
    }
    
    func fetchGoals() throws -> Array<Goal> {
        var array: Array<Goal> = []
        let goalsCD = try coreDataStack.managedContext.fetch(GoalCD.fetchRequest())
        goalsCD.forEach { gcd in
            array.append(Goal(uuid: gcd.uuid, idea: gcd.idea, description: gcd.descr, date: gcd.date, endDate: gcd.endDate))
        }
        return array
    }
    func fetchConsumptions() throws -> Array<Consumption> {
        var array: Array<Consumption> = []
        let consumptionsCD = try coreDataStack.managedContext.fetch(ConsumptionCD.fetchRequest())
        consumptionsCD.forEach { ccd in
            array.append(Consumption(uuid: ccd.uuid, quantity: Int(ccd.quantity), name: ccd.name, date: ccd.date, term: ccd.term))
        }
        return array
    }
    func fetchPrices() throws -> Array<Price> {
        var array: Array<Price> = []
        let pricesCD = try coreDataStack.managedContext.fetch(PriceCD.fetchRequest())
        pricesCD.forEach { pcd in
            array.append(Price(uuid: pcd.uuid, name: pcd.name, description: pcd.descr, date: pcd.date, price: pcd.price, benefit: pcd.benefit))
        }
        return array
    }
    
    func edit(_ goal: Goal) {
        do {
            let goalsCD = try coreDataStack.managedContext.fetch(GoalCD.fetchRequest())
            goalsCD.forEach { goalCD in
                if goalCD.uuid == goal.uuid {
                    goalCD.idea = goal.idea
                    goalCD.descr = goal.description
                    goalCD.date = goal.date
                    goalCD.endDate = goal.date
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func edit(_ consumption: Consumption) {
        do {
            let consumptionsCD = try coreDataStack.managedContext.fetch(ConsumptionCD.fetchRequest())
            consumptionsCD.forEach { ccd in
                if ccd.uuid == consumption.uuid {
                    ccd.name = consumption.name
                    ccd.quantity = Int32(consumption.quantity)
                    ccd.date = consumption.date
                    ccd.term = consumption.term
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func edit(_ price: Price) {
        do {
            let pricesCD = try coreDataStack.managedContext.fetch(PriceCD.fetchRequest())
            pricesCD.forEach { pcd in
                if pcd.uuid == price.uuid {
                    pcd.name = price.name
                    pcd.descr = price.description
                    pcd.date = price.date
                    pcd.price = price.price
                    pcd.benefit = price.benefit
                }
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func saveSkinFull(_ full: Bool) {
        do {
            let ids = try coreDataStack.managedContext.fetch(IsPrepared.fetchRequest())
            if ids.count > 0 {
                //exists
                ids[0].isFull = full
            } else {
                let isFull = IsPrepared(context: coreDataStack.managedContext)
                isFull.isFull = full
            }
            coreDataStack.saveContext()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func fetchIsSkinFull() throws -> Bool? {
        guard let isFull = try coreDataStack.managedContext.fetch(IsPrepared.fetchRequest()).first else { return nil }
        return isFull.isFull
    }
    
    func fetchGuideSkinText() throws -> String? {
        guard let text = try coreDataStack.managedContext.fetch(FoodTitle.fetchRequest()).first else { return nil }
        return text.title
    }
    
    func saveGuideSkinText() {
        let text = FoodTitle(context: coreDataStack.managedContext)
        coreDataStack.saveContext()
    }
}
