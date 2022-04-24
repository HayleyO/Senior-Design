//
//  Vibration.swift
//  hearRingiOSWatchOS WatchKit Extension
//
//  Created by Hannah Folkertsma on 2/15/22.
//

import Foundation
import WatchKit

class Vibration: NSObject{
    
    // use core data to update these!
    var controller = DataController.Controller
    
    //tracks previous volume value to determine whether the change in decibel level is significant enough for a vibration
    var storedVolume: Double = 0.0
    
    
    // vibrate according to decibel level
    // if a threshold is hit, vibrate
    // if the decibel level changes by value of decibelFrequency within the threshold, vibrate
    func vibrateOnSound(volume: Double) {
        let settings = controller.getSettings()
        let thresholdHigh: Double = settings.strongValue // high threshold
        let thresholdLow: Double = settings.weakValue  // low threshold
        let decibelFrequency: Double = 20.0 // determines the amount of vibration, and when the watch vibrates. For example, a value of 10.0 means the
                                    // vibration will occur when there is a change of 10 decibels
            if volume > thresholdHigh {
                if(storedVolume < thresholdHigh || abs(volume - storedVolume) > decibelFrequency){
                    WKInterfaceDevice.current().play(.notification)
                }
            }
            else if volume > thresholdLow {
                if(storedVolume < thresholdLow || abs(volume - storedVolume) > decibelFrequency){
                    WKInterfaceDevice.current().play(.directionUp)
                }
        }
        storedVolume = volume
    }
    
    // vibrate for alarms 
    func vibrateAlarm(){
        WKInterfaceDevice.current().play(.notification)
        WKInterfaceDevice.current().play(.notification)
        WKInterfaceDevice.current().play(.notification)
    }

}
