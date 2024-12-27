import Foundation
import CoreData


extension PriceCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PriceCD> {
        return NSFetchRequest<PriceCD>(entityName: "PriceCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var name: String
    @NSManaged public var descr: String
    @NSManaged public var date: String
    @NSManaged public var price: String
    @NSManaged public var benefit: String

}

extension PriceCD : Identifiable {

}
