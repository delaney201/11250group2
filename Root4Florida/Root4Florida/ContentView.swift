
import SwiftUI

struct ContentView: View {
    @State var zip:String
    @State var result:Zone
    @State var zipTracker:String
    @State var pollinator:Bool
    @State var plants:[Plant]
    
    @available(macOS 12.0, *)
    var body: some View {
        if #available(macOS 12.0, *) {
            VStack{
                HStack{
                    Label("Zip Code:", systemImage: "location")
                    TextField("ZipCode", text: $zip)
                        .border(.blue, width:    1)
                }
                Toggle("Pollinator Friendly", isOn: $pollinator)
                
                Text(result.numberOnly().zone)
                Text(zipTracker)
                List(plants){ plant in
                    PlantRow(plant: plant)
                }
            }
            .task(id:zip) {
                zipTracker = zip
                await update()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    //This handles the zipcode to zone conversion, then the api will search based on user preferences for plants.
    func update() async{
        do {
            let (data, _) = try await URLSession.shared.data(from: URL( string:"https://phzmapi.org/\(zip).json")!)
            let decoder = JSONDecoder()
            let zone = try decoder.decode(Zone.self, from: data)
            result = zone
            let urlString = "https://05hhyl.a.searchspring.io/api/search/search.json?ajaxCatalog=v3&resultsFormat=native&siteId=05hhyl&domain=https%3A%2F%2Fwww.brecks.com%2Fplantfinder&resultsPerPage=10&filter.ss_filter_zone=\(result.numberOnly().zone)&filter.ss_filter_usage=Pollinator%20Friendly&bgfilter.ss_hard_goods=0"
            let (plantData, _) = try await URLSession.shared.data(from: URL( string:urlString)!)
            let json = try JSON(data: plantData)
            plants.removeAll()
            for (index,subJson):(String, JSON) in json["results"] {
                plants.append(Plant(name: subJson["name"].stringValue))
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(zip: "98144", result: Zone(zone:"asdf"), zipTracker: "tracker", pollinator: true, plants: [Plant(name: "A Plant")])
    }
}



// A view that shows the data for one plant
struct PlantRow: View {
    var plant: Plant
    
    var body: some View {
        Text(plant.name)
    }
}
