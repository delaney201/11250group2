import SwiftUI

struct ToggleView: View {
    @Binding var toggled:Int
    @Binding var isOn:Bool
    let name:String
    
    var body: some View {
        ZStack{
        Toggle(name, isOn: $isOn)
                .offset(x: -10, y: 0)
        }
        .task(id:String(isOn)) {
            toggled+=1
        }
    }
        
}
