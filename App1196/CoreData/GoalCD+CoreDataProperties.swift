import Foundation
import CoreData


extension GoalCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GoalCD> {
        return NSFetchRequest<GoalCD>(entityName: "GoalCD")
    }

    @NSManaged public var uuid: UUID
    @NSManaged public var idea: String
    @NSManaged public var descr: String
    @NSManaged public var date: String
    @NSManaged public var endDate: String

}

extension GoalCD : Identifiable {

}
