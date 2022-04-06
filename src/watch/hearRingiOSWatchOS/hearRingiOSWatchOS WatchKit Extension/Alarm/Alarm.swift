//
//  Alarm.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/18/22.
//

import Foundation
import CoreData
import UserNotifications
import SwiftUI

class Alarm {
    let controller = DataController()
    let vibration = Vibration()
    var dateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        return dateFormatter
    }
    
    func processAlarmFromPhone(){
        let received = Connectivity.shared.AlarmChanged
        controller.saveAlarm(receivedAlarm: received)
        deployAlarm(alarm: controller.getAlarm(id: received.alarmID))
    }
    
    func deployAlarm(alarm: AlarmEntity){
        //notification
        let content = UNMutableNotificationContent()
        content.title = alarm.name ?? "Alarm"
        content.body = alarm.desc ?? ""
        content.categoryIdentifier = "snoozeCategory"
        
        //determine time interval
        var interval = alarm.alarmTime!.timeIntervalSinceNow
        print("\(interval) alarm interval without editing")
        if(interval <= 0){
            interval += 86400 // assume that if the alarm is at a time that has passed in the current day, that the alarm is for the next day
        }
        if(alarm.alarmTime != nil){
            print (interval)
            print ("Sending notification request for \(alarm.name ?? "alarm")")
            print(dateFormatter.string(from: alarm.alarmTime!))
            setActions()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            let request  = UNNotificationRequest(identifier: alarm.name ?? "Alarm", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
        else {
            print("No alarm time provided - alarm not set")
        }
    }
    
    func setActions(){
        // stackoverflow.com/questions/48475186
        // add snooze action
        let snoozeAction = UNNotificationAction(
            identifier: "snoozeAction", title: "Snooze", options: [.foreground]
            )
        
        let snoozeCategory = UNNotificationCategory(identifier: "snoozeCategory", actions: [snoozeAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([snoozeCategory])
        }
    }

