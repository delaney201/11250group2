import SwiftUI

struct RemindersButton: View {
    let id:String
    var body: some View {
        HStack{
            Spacer()
            Button(){
                    UIApplication.shared.open(URL(string: "x-apple-reminderkit://REMCDReminder/"+id)!)
            } label: {
                Text("View")
                    .foregroundColor(.accentColor)
            }
            
        }    }
}

