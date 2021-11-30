/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of plants.
*/

import SwiftUI

struct PlantRow: View {
    var plant: Plant

    var body: some View {
        HStack {
            AsyncImage(url:URL(string:plant.imageName)!){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
                .frame(width: 50, height: 50)
            Text(plant.name)

            Spacer()

            if plant.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var plants = ModelData().plants

    static var previews: some View {
        Group {
            PlantRow(plant: plants[0])
            PlantRow(plant: plants[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
