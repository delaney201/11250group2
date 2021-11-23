import SwiftUI
import EventKit
import EventKitUI

struct CalendarView: View {
    @State var id = ""
    @State private var date = Date()
    @State private var title = ""
    @State private var recurrenceFrequency = EKRecurrenceFrequency.daily
    @State private var interval = 1
    @State private var doesRepeat = true
    static var dateFormatter = DateFormatter()
    @State var sampleColor = Color.black
    @State var titleColor = Color.black
    
    let store = EKEventStore()
    @State var reminders:[String] = []
    
    init() {
        CalendarView.dateFormatter.dateStyle = .short
        CalendarView.dateFormatter.timeStyle = .short
        CalendarView.dateFormatter.locale = Locale(identifier: "en_US")
    }
    
    var body: some View {
        
        VStack{
            VStack{
                Text("Reminders:")
                    .font(.title2)
                if(reminders.isEmpty){
                List {
                    HStack{
                        VStack(alignment: .leading, spacing: 3){
                            Text("Water Rose Bushes (Sample)").italic().foregroundColor(sampleColor)
                            Text("Every Day\n")
                                    .foregroundColor(.secondary)
                                    .font(.caption.italic())
                                    
                            }
                        Spacer()
                        Button(action:{
                            title = "Water"
                            sampleColor = Color.gray
                            titleColor = Color.red
                            
                        }){
                            Text("Add")
                                .foregroundColor(.accentColor)
                        }
                        
                    }
                    
                }
                .listStyle(.plain)
                .frame(minHeight: .zero)
                }
                List{
                    ForEach(reminders.map({ store.calendarItem(withIdentifier: $0)!}), id: \.calendarItemExternalIdentifier) {
                        calendarItem in
                        let reminder = calendarItem as! EKReminder
                        HStack{
                            VStack(alignment: .leading, spacing: 3){
                                Text("\(reminder.title)")
                                if let reminderDate = reminder.dueDateComponents?.date {

                                    let dateStr = CalendarView.buildDateStr(reminderDate: reminderDate, recurrenceRules: reminder.recurrenceRules)
                                    Text("\(dateStr)")
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                            }
                            RemindersButton(id:reminder.calendarItemExternalIdentifier)

                        }
                    }

                    .onDelete(perform: removeReminder)
                }
                .listStyle(.plain)
                .frame(minHeight: .zero)
                Spacer()
            }
            Divider()
            Text("Add a Reminder")
                .font(.title2)
            VStack(alignment: .leading, spacing:10){
                HStack(){
                    Text("Title:")
                        .foregroundColor(titleColor)

                    TextField("Reminder Title (Required)", text:$title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Spacer()
                }
                Text("Due:")
                HStack{
                    DatePicker("", selection: $date)
                    Text("(\(CalendarView.dayOfWeek(date)))")
                    Spacer()
                }
                .padding()
            }
            VStack(alignment: .leading, spacing:10){

                Toggle(isOn: $doesRepeat) {
                    Text("Repeats")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                HStack(){
                    Text("Every:")
                        .lineLimit(1)
                    Text("\(interval)")
                        .frame(minWidth:20, minHeight: 30)
                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.secondary.opacity(0.2)))
                    Stepper("", value: $interval, in: 1...6)

                    Picker("Recurrence", selection: $recurrenceFrequency) {
                        Text("Day(s)").tag(EKRecurrenceFrequency.daily)
                        Text("Week(s)").tag(EKRecurrenceFrequency.weekly)
                    }
                    .pickerStyle(.segmented)
                    .frame(width:150)
                }
                .padding(10)
                .disabled(!doesRepeat)
                .foregroundColor(doesRepeat ? .primary : .secondary)
                HStack{
                    Spacer()
                    Button("Add", action: {
                        guard let calendar = self.store.defaultCalendarForNewReminders() else { return }
                        let newReminder = EKReminder(eventStore: store)
                        newReminder.dueDateComponents = Calendar.current.dateComponents(
                            [.year,.month,.day,.hour,.minute], from: date)
                        newReminder.calendar = calendar
                        newReminder.title = title
                        if(doesRepeat){
                            newReminder.addRecurrenceRule(EKRecurrenceRule.init(recurrenceWith: recurrenceFrequency, interval: interval, end: nil))
                        }
                        try! store.save(newReminder, commit: true)
                        id = newReminder.calendarItemExternalIdentifier!
                        reminders.append(id)
                        UserDefaults.standard.setValue(reminders, forKey: "reminders")
                        title = ""
                        sampleColor = Color.black
                        titleColor = Color.black
                    })
                        .disabled(title.isEmpty)
                }
            }
            
        }
        .onAppear (){
            updateReminders()
        }
        .onDisappear {
            updateReminders()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            updateReminders()
        }
        
        
        
    }
    
    static func buildDateStr(reminderDate:Date, recurrenceRules: [EKRecurrenceRule]?) -> String {
        var dateStr = "\(CalendarView.dayOfWeek(reminderDate, shortDate: true)) \(dateFormatter.string(from: reminderDate)) "
        if let recurrence = recurrenceRules?.first {
            dateStr += "Every "
            if(recurrence.interval > 1){
                dateStr += "\(recurrence.interval) "
            }
            switch(recurrence.frequency){
                case .daily:
                    dateStr += "Day"
                case .weekly:
                    dateStr += "Week"
                case .monthly:
                    dateStr += "Month"
                case .yearly:
                    dateStr += "Year"
                    
                default:
                    dateStr += ""
            }
            if(recurrence.interval > 1){
                dateStr += "s"
            }
            let list = recurrence.daysOfTheWeek?.map({Calendar.current.shortWeekdaySymbols[$0.dayOfTheWeek.rawValue-1]}).joined(separator: " ") ?? ""
            if(!list.isEmpty){
                dateStr += (", On ") + list
            }
            
        }
        return dateStr
    }
    
    func updateReminders(){
        askForPermission(grantedAction: {})
        reminders = []
        reminders = existingReminders((UserDefaults.standard.array(forKey: "reminders")) as? [String] ?? [String]())
        UserDefaults.standard.setValue(reminders, forKey: "reminders")
    }
    
    func existingReminders(_ reminderIds: [String]) -> [String] {
        return reminderIds.map({
            if let reminder = store.calendarItem(withIdentifier: $0){
                return reminder.calendarItemExternalIdentifier
            } else {
                return ""
            }
        })
            .filter({!$0.isEmpty})
    }
    
    func removeReminder(at offsets: IndexSet) {
        let reminder = reminders[offsets.first!]
        reminders.remove(atOffsets: offsets)
        try! store.remove(store.calendarItem(withIdentifier: reminder) as! EKReminder ,  commit: true)
        UserDefaults.standard.setValue(reminders, forKey: "reminders")
        
    }
    
    func askForPermission(grantedAction: @escaping () -> Void) {
        store.requestAccess(to: .reminder) { (granted, error) in
            if let error = error {
                print(error)
                return
            }
            
            if granted {
                grantedAction()
            }
        }
    }
    
    static func dayOfWeek(_ date: Date, shortDate:Bool = false) -> String{
        let currentCalendar = Calendar.current
        let weekDay = currentCalendar.component(.weekday, from: date) - 1
        return shortDate ? currentCalendar.shortWeekdaySymbols[weekDay] : currentCalendar.weekdaySymbols[weekDay]
        
    }
    
}
