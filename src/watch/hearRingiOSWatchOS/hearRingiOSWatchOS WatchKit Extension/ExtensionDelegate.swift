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
        print("active")
        authorization.requestAuthorization()
    }
  
}

