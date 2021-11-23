import Foundation

class NumberHelper {
    static func numberOnly(string: String) -> Int {
        if let number = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            return number
        }
        return -1
    }
}
