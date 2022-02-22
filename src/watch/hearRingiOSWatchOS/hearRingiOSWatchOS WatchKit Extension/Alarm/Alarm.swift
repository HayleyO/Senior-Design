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
     //   let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
      //  let alarmRequest = NSFetchRequest<NSManagedObject>(entityName: "AlarmEntity")
        //do{
     //       let alarms = try context.fetch(alarmRequest).first
     //       print(alarms)
       // }
      //      catch
        //{
          //      print("Error fetching alarms")
            //}
    }
    
    func deployAlarm() async{
        //notification
        let center = UNUserNotificationCenter.current()
        let content = UNNotificationContent()
        //let request = UNNotificationRequest(identifier: "Alarm", content: content, trigger: Timer(timeInterval: 90, repeats: false, block: <#T##(Timer) -> Void#>))
        //center.add(<#T##request: UNNotificationRequest##UNNotificationRequest#>, withCompletionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
        
        //vibrate for alarm
    }
    
    func snooze(){
        //add 9 minutes to alarm time
    }
}
