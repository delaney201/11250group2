import Foundation
import SwiftUI
import CoreLocation

struct Plant: Hashable, Codable, Identifiable {
    var id: String
    var name: String
    var description: String
    var isFavorite: Bool = false
    func styledDescription() -> String {
        "<html><head><meta name=\"viewport\" content=\"width=device-width, shrink-to-fit=YES\"></head><style>html{ padding:0px; margin:0px;}</style></html>" + description.stringByDecodingHTMLEntities
    }
    var imageName: String
    init(id:String, name:String, description:String, imageName:String){
        self.id = id
        self.name = name
        self.description = description
        self.imageName = imageName
        print(id)
    }
    static func thumbnail(_ id:String) -> String {
        "https://h2.commercev3.net/cdn.brecks.com/images/350/\(id).jpg"
    }
}

enum Exposure:String {
    case Full = "&filter.ss_filter_exposure=Full%20Sun"
    case Partial = "&filter.ss_filter_exposure=Partial%20Shade"
    case Shade = "&filter.ss_filter_exposure=Full%20Shade"
}
