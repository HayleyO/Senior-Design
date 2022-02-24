//
//  NotificationAuthorization.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/21/22.
//

import Foundation
import UserNotifications

class NotificationAuthorization {
    func requestAuthorization(){
        let center = UNUserNotificationCenter.current()
        let options = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        center.requestAuthorization(options: options) { (success, error) in
            if let error = error
            {
                print("Error: ", error)
            }
        }
    }
}
