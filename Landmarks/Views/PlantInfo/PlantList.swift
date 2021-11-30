/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of plants.
*/

import SwiftUI

struct PlantList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false

    var filteredPlants: [Plant] {
        modelData.plants.filter { plant in
            (!showFavoritesOnly || plant.isFavorite)
        }
    }

    var body: some View {
        Text("Plants").font(.title2)
        Toggle(isOn: $showFavoritesOnly) {
            Text("Favorites only")
        }
        NavigationView {
            if(filteredPlants.isEmpty){
                Text("No Results")
            } else {
            List {
                ForEach(filteredPlants.sorted(by: { $0.name < $1.name })) { plant in
                    NavigationLink {
                        PlantDetail(plant: plant)
                    } label: {
                        PlantRow(plant: plant)
                    }
                }
            }
            .navigationBarTitle("Plants", displayMode: .inline)
            .navigationBarHidden(true)
            .listStyle(PlainListStyle())
            }
        }

    }
}

struct PlantList_Previews: PreviewProvider {
    static var previews: some View {
        PlantList()
            .environmentObject(ModelData())
    }
}
