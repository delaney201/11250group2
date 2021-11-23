import SwiftUI
struct MainView: View {
    var body: some View{
        TabView{
            PlantsView()
                .padding()
                .tabItem {Image(systemName: "magnifyingglass")}
            CalendarView()
                .padding()
                .tabItem { Image(systemName: "calendar")}
            TipsView()
                .padding()
                .tabItem { Image(systemName: "info.circle")}
        }
    }
}


