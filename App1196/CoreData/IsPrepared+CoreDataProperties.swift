import Foundation
import CoreData


extension IsPrepared {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IsPrepared> {
        return NSFetchRequest<IsPrepared>(entityName: "IsPrepared")
    }

    @NSManaged public var isFull: Bool

}

extension IsPrepared : Identifiable {

}
