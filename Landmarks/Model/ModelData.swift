import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var plants: [Plant] = load("landmarkData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    var file = Bundle.main.url(forResource: filename, withExtension: nil)
    if(file == nil){
        file = FileUtils.getDocumentsDirectory().appendingPathComponent(filename) }
    
    
    do {
        data = try Data(contentsOf: file!)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

