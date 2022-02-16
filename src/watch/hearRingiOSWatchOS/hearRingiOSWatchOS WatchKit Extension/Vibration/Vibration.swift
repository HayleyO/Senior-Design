//
//  Vibration.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/15/22.
//

import Foundation
import WatchKit

class Vibration: NSObject{
    
    // vibrate according to decibel level
    func vibrateOnSound(volume: Float) {
        if volume > 90.0 {
            WKInterfaceDevice.current().play(.notification)
        }
        else if volume > 50.0 {
            WKInterfaceDevice.current().play(.navigationGenericManeuver)
        }
    }
    
    // vibrate for alarms 
    func vibrateAlarm(){
        WKInterfaceDevice.current().play(.notification)
    }
}
