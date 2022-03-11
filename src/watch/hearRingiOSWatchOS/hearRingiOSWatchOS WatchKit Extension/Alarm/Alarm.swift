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
    
    func getAlarms(){
     /* let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        let alarmRequest = NSFetchRequest<NSManagedObject>(entityName: "AlarmEntity")
        do{
            let alarms = try context.fetch(alarmRequest).first
            print(alarms)
        }
            catch
        {
                print("Error fetching alarms")
            } */
    }
    
    func deployAlarm(){
        //notification
        let content = UNMutableNotificationContent()
        content.title = "test alarm"
        content.body = "alarm is going off!"
        content.categoryIdentifier = "snoozeCategory"
        
        setActions()
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30.0, repeats: false)
        let request  = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        //vibrate for alarm
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

