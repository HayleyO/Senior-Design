//
//  Alarm.swift
//  hearRingiOSWatchOS
//
//  Created by Ashley Palmer on 2/15/22.
//

import SwiftUI

struct Alarm: Hashable, Codable, Identifiable {
  var id = UUID()
  var name: String
  var alarmTime: String
  var isEnabled: Bool = false
}

extension Alarm {
  static let samples = [
    Alarm(name: "Wake Up for 8 AM Class", alarmTime: "7:00 AM"),
    Alarm(name: "Unholy Hour in the Morning", alarmTime: "5:00 AM"),
    Alarm(name: "Don't Forget to Eat Dinner", alarmTime: "5:30 PM"),
    Alarm(name: "Take Medicine", alarmTime: "12:00 PM")
  ]
}
