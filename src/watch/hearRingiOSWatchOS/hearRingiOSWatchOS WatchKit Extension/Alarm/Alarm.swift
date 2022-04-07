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
    let controller = DataController.Controller
    let vibration = Vibration()
    
    func processAlarmFromPhone(){
        let recieved = Connectivity.shared.AlarmChanged
        controller.saveAlarm(receivedAlarm: recieved)
    }
    
    func deployAlarm(alarm: AlarmEntity){
        //notification
        let content = UNMutableNotificationContent()
        content.title = alarm.name ?? "Alarm"
        content.body = alarm.desc ?? ""
        content.categoryIdentifier = "snoozeCategory"
        
        //determine time interval
        if(alarm.alarmTime != nil){
            let interval = abs(Date.now.timeIntervalSince1970 - alarm.alarmTime!.timeIntervalSince1970)
            print (interval)
        
            setActions()
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
            let request  = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            //vibrate for alarm
            
            vibration.vibrateAlarm()
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

