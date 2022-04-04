//
//  AlarmEdit.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/15/22.
//

import SwiftUI
import CoreData

struct AlarmEdit: View {
    var alarm: AlarmEntity
    var dateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    @State private var calendar = Calendar.current
    @State private var newName = ""
    @State private var newTime = Date.now
    @State private var newDate = Date.now
    @State private var newDesc = ""
    @State private var isEnabled = false
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            TextField("Please enter a name", text: $newName,
                prompt: Text(alarm.name ?? "Provide a name")
                )
                .font(.title)
                .padding()
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            
            HStack{
                DatePicker("Please enter a time", selection: $newTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .padding()
                    .font(.title2)
            DatePicker("Please enter a date",
                    selection: $newDate, displayedComponents: .date)
                    .labelsHidden()
            }
                
            
            TextField("Please enter a description", text: $newDesc,
                prompt: Text(alarm.desc ?? "Provide a description")
            )
                .padding()
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
            
            Toggle("Turn Alarm On/Off", isOn: $isEnabled)
                .padding()
                .onChange(of: isEnabled){ value in
                    alarm.isEnabled = value

                    Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, delivery: .failable)
                    
                    print(alarm.isEnabled)

                    try? moc.save()

                }
            
            Spacer()
            Button(action: {
                moc.delete(alarm)
                try? moc.save()
            }, label: {
                Text("Delete")
                    .foregroundColor(Color.red)
            }
            )
                .accessibilityLabel("Delete")
                .padding()
        }
        .onAppear {
            newName = alarm.name ?? ""
            newTime = alarm.alarmTime ?? Date.now
            newDesc = alarm.desc ?? ""
            isEnabled = alarm.isEnabled
        }
        .onDisappear {
            alarm.name = newName
            newTime = calendar.date(bySettingHour: calendar.component(.hour, from: newTime), minute: calendar.component(.minute, from: newTime), second: calendar.component(.second, from: newTime), of: newDate)!
            alarm.alarmTime = newTime
            alarm.desc = newDesc
    
            Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, delivery: .guaranteed)
        }
    }
}

struct AlarmEdit_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEdit(alarm: AlarmEntity())
    }
}
