//
//  Alarm.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/18/22.
//

import Foundation
import CoreData

class Alarm {
    
    func getAlarms(){
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        let alarmRequest = NSFetchRequest<NSManagedObject>(entityName: "AlarmEntity")
        do{
            let alarms = try context.fetch(alarmRequest).first
            print(alarms)
        }
            catch
        {
                print("Error fetching alarms")
            }
    }
    
    func deployAlarm(){
        //notification
        //vibrate for alarm
    }
    
    func snooze(){
        //add 9 minutes to alarm time
    }
}
