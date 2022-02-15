//
//  AlarmEdit.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/15/22.
//

import SwiftUI

struct AlarmEdit: View {
    var alarm: Alarm
    var body: some View {
        VStack{
            Text(alarm.name)
                .font(.title)
            
            Text(alarm.alarmTime)
                .font(.title2)
        }
    }
}

struct AlarmEdit_Previews: PreviewProvider {
    static var previews: some View {
        AlarmEdit(alarm: Alarm.samples[0])
    }
}
