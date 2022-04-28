//
//  ExtensionDelegate.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/21/22.
//

import Foundation
import WatchKit
import UserNotifications
import CoreData

class ExtensionDelegate: NSObject, WKExtensionDelegate{
    
    let container = NSPersistentContainer(name: "Model")
    let alarms = DispatchQueue(label:"alarmQueue")
    let v = Vibration()
    
    func applicationDidFinishLaunching() {
        // authorization to allow notifications
        let authorization = NotificationAuthorization()
        authorization.requestAuthorization()
        UNUserNotificationCenter.current().delegate = self
    }
   
    
    // what happens when the notification center recieves certain responses for notifications
    // just using this for snooze at the moment
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if(response.actionIdentifier == "snoozeAction"){
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300.0, repeats: false)
            let newRequest = UNNotificationRequest(identifier: "snoozeAlarm", content: response.notification.request.content, trigger: trigger)
            UNUserNotificationCenter.current().add(newRequest)
        }
        completionHandler()
    }
}

// this makes the notifications show up when the app is in the foreground
// stackoverflow.com/questions/14872088
extension ExtensionDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
        alarms.async {
            self.v.vibrateAlarm()
        }
    }

}


