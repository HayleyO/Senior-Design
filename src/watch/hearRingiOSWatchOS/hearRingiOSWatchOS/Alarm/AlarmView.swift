//
//  AlarmView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI
import CoreData

struct AlarmView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.alarmTime), SortDescriptor(\.name)]) var alarms: FetchedResults<AlarmEntity>
    @Environment(\.managedObjectContext) var moc
    
    var dateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
  var body: some View {
      NavigationView {
          List {
              ForEach(alarms, id: \.self) { alarm in
                NavigationLink {
                    AlarmEdit(alarm: alarm)
                } label: {
                    if (alarm.isEnabled && alarm.alarmTime?.timeIntervalSinceNow.sign == .plus)
                    {
                        HStack(alignment: .top) {
                          VStack(alignment: .leading) {
                              if (Calendar.current.isDateInToday(alarm.alarmTime ?? Date.now)) {
                                  HStack (spacing: 0) {
                                      Text("Today at ")
                                      Text(alarm.alarmTime ?? Date.now, style: .time)
                                  }
                                  .font(.headline)
                              }
                              else if (Calendar.current.isDateInTomorrow(alarm.alarmTime ?? Date.now)) {
                                  HStack (spacing: 0) {
                                      Text("Tomorrow at ")
                                      Text(alarm.alarmTime ?? Date.now, style: .time)
                                  }
                                  .font(.headline)
                              }
                              else {
                                  Text(dateFormatter.string(for: alarm.alarmTime) ?? "TimeUnknown")
                                  .font(.headline)
                              }
                            Text(alarm.name ?? "NameUnknown")
                              .font(.subheadline)
                          }
                          Spacer()
                        }
                    }
                    else {
                        HStack(alignment: .top) {
                          VStack(alignment: .leading) {
                              if (Calendar.current.isDateInToday(alarm.alarmTime ?? Date.now)) {
                                  HStack (spacing: 0) {
                                      Text("Today at ")
                                      Text(alarm.alarmTime ?? Date.now, style: .time)
                                  }
                                  .font(.headline)
                              }
                              else if (Calendar.current.isDateInTomorrow(alarm.alarmTime ?? Date.now)) {
                                  HStack (spacing: 0) {
                                      Text("Tomorrow at ")
                                      Text(alarm.alarmTime ?? Date.now, style: .time)
                                  }
                                  .font(.headline)
                              }
                              else {
                                  Text(dateFormatter.string(for: alarm.alarmTime) ?? "TimeUnknown")
                                  .font(.headline)
                              }
                              Text(alarm.name ?? "NameUnknown")
                                  .font(.subheadline)
                          }
                          .foregroundColor(.secondary)
                          Spacer()
                        }
                    }
                }
              }
              .onDelete(perform: delete)
            }
            .navigationTitle("Alarms")
            .toolbar {
                NavigationLink(destination: AlarmCreate()) {
                    Image(systemName: "plus")
                }
                .accessibilityIdentifier("Create New Alarm")
            }
      }
      .onAppear() {
          //sortedAlarms = alarms.sorted(by: { $0.alarmTime!.compare($1.alarmTime!) == .orderedDescending })
          Connectivity.shared.SendFirst()
      }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
                let alarm = alarms[index]
                moc.delete(alarm)
                Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, isDeleted: true, delivery: .guaranteed)
            }
        try? moc.save()
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
