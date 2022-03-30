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
    var alarmChanged: Connectivity.AlarmInfo = Connectivity.shared.AlarmChanged {
        didSet{
            print("changed")
        }
    }
    
    func testSave(decodedAlarm: Connectivity.AlarmInfo){
        let controller = DataController()
        let sendAlarm = AlarmEntity(context: controller.container.viewContext)
        sendAlarm.id = decodedAlarm.alarmID
        sendAlarm.alarmTime = decodedAlarm.alarmTime
        sendAlarm.desc = decodedAlarm.alarmDescription
        sendAlarm.name = decodedAlarm.alarmName
        sendAlarm.isEnabled = decodedAlarm.alarmEnabled
        controller.saveAlarm(alarm: sendAlarm)
        print("here")
    }
    
    func processAlarmFromPhone(){
        let newAlarm = AlarmEntity(context: controller.container.viewContext)
        let recieved = Connectivity.shared.AlarmChanged
        newAlarm.name = recieved.alarmName
        newAlarm.desc = recieved.alarmDescription
        newAlarm.alarmTime = recieved.alarmTime
        newAlarm.id = recieved.alarmID
        print("processing")
        controller.saveAlarm(alarm: newAlarm)
    }
    
    func prepareAlarms(){
        let results = controller.getAlarms()
        print(results)
        print("alarms are here")
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

