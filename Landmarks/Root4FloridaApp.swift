import SwiftUI
import EventKit
import EventKitUI

@main
struct Root4FloridaApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        
        WindowGroup {
            MainView()
        }
    }
}
