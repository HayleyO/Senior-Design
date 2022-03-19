//
//  AlarmView.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/14/22.
//

import SwiftUI
import CoreData

struct AlarmView: View {
  @FetchRequest(sortDescriptors: []) var alarms: FetchedResults<AlarmEntity>
  @Environment(\.managedObjectContext) var moc
    
    var dateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
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
                    if (alarm.isEnabled)
                    {
                        HStack(alignment: .top) {
                          VStack(alignment: .leading) {
                              Text(dateFormatter.string(for: alarm.alarmTime) ?? "TimeUnknown")
                              .font(.headline)
                            Text(alarm.name ?? "NameUnknown")
                              .font(.subheadline)
                          }
                          Spacer()
                        }
                    }
                    else {
                        HStack(alignment: .top) {
                          VStack(alignment: .leading) {
                            Text(dateFormatter.string(for: alarm.alarmTime) ?? "TimeUnknown")
                              .font(.headline)
                              .foregroundColor(.secondary)
                            Text(alarm.name ?? "NameUnknown")
                              .font(.subheadline)
                              .foregroundColor(.secondary)
                          }
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
            }
      }
    }
    func delete(at offsets: IndexSet) {
        for index in offsets {
                let alarm = alarms[index]
                moc.delete(alarm)
            }
        try? moc.save()
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
