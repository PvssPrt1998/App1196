import Foundation

final class Source: ObservableObject {
    
    let dataManager = DataManager()
    
    var skinDescription = ""
    var show = false
    
    @Published var consumptions: Array<Consumption> = []
    @Published var prices: Array<Price> = []
    @Published var goals: Array<Goal> = []
    
    func load(completion: () -> Void) {
        if let ccds = try? dataManager.fetchConsumptions() {
            consumptions = ccds
        }
        if let pcds = try? dataManager.fetchPrices() {
            prices = pcds
        }
        if let gcds = try? dataManager.fetchGoals() {
            goals = gcds
        }
        completion()
    }
    
    func save(_ price: Price) {
        prices.append(price)
        dataManager.save(price)
    }
    func save(_ consumption: Consumption) {
        consumptions.append(consumption)
        dataManager.save(consumption)
    }
    func save(_ goal: Goal) {
        goals.append(goal)
        dataManager.save(goal)
    }
    
    func edit(_ goal: Goal) {
        guard let index = goals.firstIndex(where: {$0.uuid == goal.uuid}) else { return }
        goals[index] = goal
        dataManager.edit(goal)
    }
    
    func edit(_ price: Price) {
        guard let index = prices.firstIndex(where: {$0.uuid == price.uuid}) else { return }
        prices[index] = price
        dataManager.edit(price)
    }
    
    func edit(_ consumption: Consumption) {
        guard let index = consumptions.firstIndex(where: {$0.uuid == consumption.uuid}) else { return }
        consumptions[index] = consumption
        dataManager.edit(consumption)
    }
    
    func incrementConsumption(_ index: Int) {
        consumptions[index].quantity += 1
        dataManager.edit(consumptions[index])
    }
    func decrementConsumption(_ index: Int) {
        consumptions[index].quantity -= 1
        dataManager.edit(consumptions[index])
    }
    
}
