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
    @State private var isEnabled = false
    var body: some View {
        VStack{
            Text(alarm.name ?? "NameUnknown")
                .font(.title)
            
            Text(alarm.alarmTime ?? "TimeUnknown")
                .font(.title2)
            
            Toggle("Turn Alarm On/Off", isOn: $isEnabled)
                .padding()
                .onChange(of: isEnabled){ value in
                    alarm.isEnabled = value
                    Connectivity.shared.send(AlarmTime: alarm.alarmTime!, alarmEnabled: alarm.isEnabled, alarmID: alarm.id!, alarmName: alarm.name!, delivery: .highPriority)
                    print(alarm.isEnabled)
                }
        }
        .onAppear {
            isEnabled = alarm.isEnabled
        }
    }
}

struct AlarmEdit_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEdit(alarm: AlarmEntity())
    }
}
