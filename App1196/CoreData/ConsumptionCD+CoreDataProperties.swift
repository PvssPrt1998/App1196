import Foundation
import CoreData


extension ConsumptionCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsumptionCD> {
        return NSFetchRequest<ConsumptionCD>(entityName: "ConsumptionCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var quantity: Int32
    @NSManaged public var name: String
    @NSManaged public var date: String
    @NSManaged public var term: String

}

extension ConsumptionCD : Identifiable {

}
