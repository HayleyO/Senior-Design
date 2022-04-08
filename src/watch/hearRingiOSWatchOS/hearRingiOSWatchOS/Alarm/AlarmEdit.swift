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
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    @State private var isDeleted = false
    @State private var calendar = Calendar.current
    @State private var newName = ""
    @State private var newTime = Date.now
    @State private var newDesc = ""
    @State private var isEnabled = false
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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
                    selection: $newTime, displayedComponents: .date)
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

                    Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, isDeleted: false, delivery: .failable)
                    
                    print(alarm.isEnabled)

                    try? moc.save()

                }
            
            Spacer()
            Button(action: {
                isDeleted = true
                Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, isDeleted: isDeleted, delivery: .guaranteed)
                moc.delete(alarm)
                try? moc.save()
                self.presentationMode.wrappedValue.dismiss()
            },
            label: {
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
            isDeleted = false
        }
        .onDisappear {
            if(!isDeleted){
                alarm.name = newName
                alarm.alarmTime = newTime.addingTimeInterval(-1.0 * Double(calendar.component(.second, from: newTime)))
                alarm.desc = newDesc
                Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, alarmDescription: alarm.desc!, isDeleted: isDeleted, delivery: .guaranteed)
            }
            
            try? moc.save()
        }
    }
}

struct AlarmEdit_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEdit(alarm: AlarmEntity())
    }
}
