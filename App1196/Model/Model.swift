import Foundation

struct Consumption: Hashable {
    let uuid: UUID
    var quantity: Int
    var name: String
    var date: String
    var term: String
}

struct Price: Hashable {
    let uuid: UUID
    var name: String
    var description: String
    var date: String
    var price: String
    var benefit: String
}

struct Goal: Hashable {
    let uuid: UUID
    var idea: String
    var description: String
    var date: String
    var endDate: String
}
