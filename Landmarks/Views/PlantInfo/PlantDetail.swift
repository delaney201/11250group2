/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A view showing the details for a plant.
 */

import SwiftUI

struct PlantDetail: View {
    @EnvironmentObject var modelData: ModelData
    var plant: Plant
    
    var plantIndex: Int {
        print(plant.id)
        return modelData.plants.firstIndex(where: { $0.id == plant.id }) ?? -1
    }
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .center) {
                AsyncImage(url:URL(string:plant.imageName)!){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
                .frame(width: 125, height: 125)
                HStack {
                    Text(plant.name)
                        .font(.title)
                    if(plantIndex != -1){
                        FavoriteButton(isSet: $modelData.plants[plantIndex].isFavorite)
                    }
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(plant.name)")
                    .font(.title2)
                WebView(htmlString: .constant( plant.styledDescription()), baseURL: .constant(nil))
                    .padding(0)
                    .frame(minHeight:200)
            }
            .padding()
        }
        .navigationTitle(plant.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlantDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        PlantDetail(plant: modelData.plants[0])
            .environmentObject(modelData)
    }
}
