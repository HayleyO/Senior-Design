//
//  AlarmCreate.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 3/16/22.
//

import SwiftUI
import CoreData

struct AlarmCreate: View {
    var dateFormatter : DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    @State private var calendar = Calendar.current
    @State private var newTime = Date()
    @State private var newName = ""
    @State private var newDesc = ""
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            Form {
                HStack{
                    DatePicker("Please enter a time", selection: $newTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .padding()
                    DatePicker("Please enter a date", selection: $newTime, displayedComponents: .date)
                        .labelsHidden()
                        .padding()
                }
                
                TextField(text: $newName, prompt: Text("Name your new alarm")) {
                    Text("Name")
                }
                .padding()
                
                TextField(text: $newDesc, prompt: Text("Provide an optional description")) {
                    Text("Description")
                }
                .padding()
            }
            
            Button("Save", action: { self.presentationMode.wrappedValue.dismiss()
                let newalarm = AlarmEntity(context: moc)
                          newalarm.id = UUID()
                          newalarm.alarmTime = newTime
                          newalarm.name = newName
                          newalarm.desc = newDesc
                          newalarm.isEnabled = true
                try? moc.save()
                Connectivity.shared.send(AlarmTime: newalarm.alarmTime!, alarmEnabled: newalarm.isEnabled, alarmID: newalarm.id!, alarmName: newalarm.name!, alarmDescription: newalarm.desc!, delivery: .guaranteed)
                }
            )
                .padding()
            
            Divider()
                .padding()
        }
    }
}

struct AlarmCreate_Previews: PreviewProvider {
    static var previews: some View {
        AlarmCreate()
    }
}
