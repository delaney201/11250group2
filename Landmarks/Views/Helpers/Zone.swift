import Foundation
struct Zone: Codable {
    static let zipRegex = try! NSRegularExpression(pattern: "[0-9]{5}")
    var zone: String
    func numberOnly() -> Zone {
        let number = NumberHelper.numberOnly(string: zone)
        return number != -1 ? Zone(zone:String(number)) : Zone(zone:"None")
    }
    static func isValidZip(zip:String) -> Bool{
        if(zip.isEmpty){
            return true
        }
        let zipRange = NSRange(zip.startIndex..<zip.endIndex,in: zip)
        return Zone.zipRegex.numberOfMatches(in: zip,range:zipRange) == 1
    }
}
