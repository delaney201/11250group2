
import Foundation
struct Zone: Codable {
    var zone: String
    func numberOnly() -> Zone {
        if let number = Int(zone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            return Zone(zone:String(number))
        }
        return Zone(zone:"None")
    }
}

