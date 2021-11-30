import SwiftUI

struct PlantsView: View {
    @StateObject private var modelData = ModelData()
    @State private var showingFilters = true
    @State var toggled = 0
    
    @State var zip:String = ""
    @State var result:Zone = Zone(zone: "")
    @State var zipTracker:String = ""
    
    @State var pollinator:Bool = true
    @State var fullSun:Bool = false
    @State var partialShade:Bool = false
    @State var fullShade:Bool = false
    
    @State var searchText:String = ""
    
    let pollinatorStr:String = "&filter.ss_filter_usage=Pollinator%20Friendly"

    
    @State var leftList:Array<Filter> = [Filter(name:"Black"),Filter(name:"Blue"),Filter(name:"Green"),
                                         Filter(name:"Mixed"),Filter(name:"Orange")]
    @State var rightList:Array<Filter> = [Filter(name:"Pink"),
                                          Filter(name:"Purple"),Filter(name:"Red"),Filter(name:"White"),
                                          Filter(name:"Yellow")]
    
    @State var plants:[Plant] = []
    
    var body: some View {
        
        VStack {
            Text("Plant Finder")
                .font(.title)
            Toggle("   Show Filters", isOn: $showingFilters.animation())
                .offset(x: -10, y: -10)
            Divider()
            
            if showingFilters {
                VStack(){
                    HStack{
                        Label("Search:", systemImage: "magnifyingglass").frame(minWidth:100)
                        TextField(" Keyword", text: $searchText)
                            .autocapitalization(UITextAutocapitalizationType.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        //.padding(15)
                    }
                    HStack{
                        Label("Zip Code:", systemImage: "location").frame(minWidth:100)
                        TextField(" Zip Code", text: $zip)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Divider()
                    Toggle("   Pollinator Friendly", isOn: $pollinator)
                        .offset(x: -10, y: 0)
                    Divider()
                    VStack{
                        ToggleView(toggled: $toggled, isOn: $fullSun, name: " Full Sun   ")
                        //.offset(x: -10, y: 0)
                        ToggleView(toggled: $toggled, isOn: $partialShade, name: " Partial Shade   ")
                        //.offset(x: -10, y: 0)
                        ToggleView(toggled: $toggled, isOn: $fullShade, name: " Full Shade   ")
                        //.offset(x: -10, y: 0)
                    }
                    .padding(5)
                    //.offset(x: -10, y: -10)
                    Divider()
                    HStack{
                        VStack{
                            ForEach($leftList, id: \.id){
                                $filter in
                                ToggleView(toggled: $toggled, isOn: $filter.isOn, name: "   "+filter.name)
                                
                            }}
                        VStack{
                            ForEach($rightList, id: \.id){
                                $filter in
                                ToggleView(toggled: $toggled, isOn: $filter.isOn, name: "   "+filter.name)
                                
                            }
                        }
                    }
                }
            }
            PlantList()
                .environmentObject(modelData)
            
        }
        .task(id:zip+searchText+String(pollinator)+String(toggled)) {
            await update()
        }

        .onAppear{zip = "32608"}
    }
    
    func toggle(name:String) -> String{
        toggled += 1
        return name
    }
    
    func update() async{
        if(Zone.isValidZip(zip: zip)) {
            do {
                let colorString = (leftList+rightList).map { $0.filterString()}.joined()
                var urlString = "https://05hhyl.a.searchspring.io/api/search/search.json?" +
                "\(searchText.isEmpty ? "" : "q=\(searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)")" +
                (pollinator ? pollinatorStr : "" )
                + "&ajaxCatalog=v3&resultsFormat=native&siteId=05hhyl&domain=https%3A%2F%2Fwww.brecks.com%2Fplantfinder&resultsPerPage=10"
                if(!zip.isEmpty){
                    let (data, _) = try await URLSession.shared.data(from: URL( string:"https://phzmapi.org/\(zip).json")!)
                    let decoder = JSONDecoder()
                    result = try decoder.decode(Zone.self, from: data)
                    urlString = urlString + "&filter.ss_filter_zone=\(result.numberOnly().zone)"
                }
                urlString = urlString + "&bgfilter.ss_hard_goods=0\(colorString)\(fullSun ? Exposure.Full.rawValue:"")\(partialShade ? Exposure.Partial.rawValue:"")\(fullShade ? Exposure.Shade.rawValue:"")"
                print("URL: " + urlString)
                let (plantData, _) = try await URLSession.shared.data(from: URL( string:urlString)!)
                let json = try JSON(data: plantData)
                let url = FileUtils.getDocumentsDirectory().appendingPathComponent("plantData.json")            
                plants.removeAll()
                var jsonData = ""
                for (_, subJson):(String, JSON) in json["results"] {
                        jsonData += "{\"id\":\"\(subJson["sku"].stringValue)\"," +
                    "\"name\":\"\(subJson["ss_name_stripped"].stringValue)\"," +
                    "\"description\":\"\(subJson["description"].stringValue)\",\"isFavorite\":false," +
                    "\"imageName\":\"\(Plant.thumbnail(subJson["sku"].stringValue))\"},"
                          
                }
                try? "[\(jsonData)]".replacingOccurrences(of: "\n", with: "").write(to: url, atomically: true, encoding: .utf8)
                let input = try String(contentsOf: url)
                print(input)
                modelData.plants = load("plantData.json")
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

struct Filter: Identifiable {
    static let colorStr:String = "&filter.ss_filter_colour="
    let id = UUID()
    var name: String
    var isOn: Bool = false
    func filterString() -> String {
        isOn ? Filter.colorStr + name : ""
    }
}



