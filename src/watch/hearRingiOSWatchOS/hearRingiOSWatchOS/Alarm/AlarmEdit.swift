//
//  AlarmEdit.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/15/22.
//

import SwiftUI

struct AlarmEdit: View {
    var alarm: Alarm
    @State private var isEnabled = false
    var body: some View {
        VStack{
            Text(alarm.name)
                .font(.title)
            
            Text(alarm.alarmTime)
                .font(.title2)
            
            Toggle("Turn Alarm On/Off", isOn: $isEnabled)
                .padding()
                .onChange(of: isEnabled){ value in
                    alarm.isEnabled = value
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
        //AlarmEdit(alarm: Alarm.samples[0])
        AlarmEdit(alarm: alarms[0])
    }
}
