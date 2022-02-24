//
//  ExtensionDelegate.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/21/22.
//

import Foundation
import WatchKit
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate{
    
    func applicationDidBecomeActive() {
        let authorization = NotificationAuthorization()
        let alarm = Alarm()
        authorization.requestAuthorization()
        
        //deploying alarm here for testing 
        UNUserNotificationCenter.current().delegate = self
        alarm.deployAlarm()
    }
}

extension ExtensionDelegate : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.banner)
    }
}

