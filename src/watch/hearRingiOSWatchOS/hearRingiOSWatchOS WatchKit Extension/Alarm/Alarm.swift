//
//  Alarm.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/18/22.
//

import Foundation
import CoreData
import UserNotifications

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
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30.0, repeats: false)
        let request  = UNNotificationRequest(identifier: "alarm", content: content, trigger: trigger)
        print("requesting")
        UNUserNotificationCenter.current().add(request)
        //vibrate for alarm
    }
    
    func snooze(){
        //add 9 minutes to alarm time
    }
}
