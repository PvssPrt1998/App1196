import Foundation
import CoreData


extension FoodTitle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodTitle> {
        return NSFetchRequest<FoodTitle>(entityName: "FoodTitle")
    }

    @NSManaged public var title: String?

}

extension FoodTitle : Identifiable {

}
